//
//  ARSProgressLoader.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 09/10/2016.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//
//  Website: http://arsenkin.com
//

import UIKit

final class ARSProgressLoader: ARSLoader {
	
	@objc var emptyView = UIView()
	@objc var backgroundBlurView: UIView
	@objc var backgroundSimpleView: UIView
	@objc var backgroundFullView: UIView
	@objc var backgroundView: UIView {
		switch ars_config.backgroundViewStyle {
		case .blur:
			return backgroundBlurView
		case .simple:
			return backgroundSimpleView
		case .full:
			return backgroundFullView
		}
	}
	@objc var outerCircle = CAShapeLayer()
	@objc var middleCircle = CAShapeLayer()
	@objc var innerCircle = CAShapeLayer()
	var multiplier: CGFloat = 1.0
	var lastMultiplierValue: CGFloat = 0.0
	var progressValue: CGFloat = 0.0
	var progress: Progress?
	var failed = false
	static weak var weakSelf: ARSProgressLoader?
	@objc weak var targetView: UIView?
	
	init() {
		backgroundBlurView = ARSBlurredBackgroundRect().view
		backgroundSimpleView = ARSSimpleBackgroundRect().view
		backgroundFullView = ARSFullBackgroundRect().view
		ARSProgressLoader.weakSelf = self
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(ARSInfiniteLoader.orientationChanged(_:)),
		                                       name: NSNotification.Name.UIDeviceOrientationDidChange,
		                                       object: nil)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self,
		                                          name: NSNotification.Name.UIDeviceOrientationDidChange,
		                                          object: nil)
	}
	
	@objc func orientationChanged(_ notification: Notification) {
		ars_dispatchOnMainQueue {
			if let loader = ars_currentLoader {
				if let targetView = loader.targetView {
					ars_createdFrameForBackgroundView(loader.backgroundView, onView: targetView)
				} else {
					ars_createdFrameForBackgroundView(loader.backgroundView, onView: nil)
				}
			}
		}
	}
	
}

extension ARSProgressLoader {
	
	// MARK: Show/Cancel
	
	func ars_showWithValue(_ value: CGFloat, onView view: UIView?, progress: Progress?, completionBlock: (() -> Void)?) {
		if ars_createdFrameForBackgroundView(backgroundView, onView: view) == false { return }
		if let progress = progress { self.progress = progress }
		
		ars_currentCompletionBlock = completionBlock
		targetView = view
		
		ars_createCircles(outerCircle,
		                  middleCircle: middleCircle,
		                  innerCircle: innerCircle,
		                  onView: ((backgroundView as? UIVisualEffectView)?.contentView) ?? backgroundView,
		                  loaderType: .progress)
		ars_animateCircles(outerCircle, middleCircle: middleCircle, innerCircle: innerCircle)
		ars_presentLoader(self, onView: view, completionBlock: nil)
		ars_launchTimer()
	}
	
	func ars_cancelWithFailAnimation(_ failAnim: Bool, completionBlock: (() -> Void)?) {
		if failAnim {
			ars_currentCompletionBlock = completionBlock
			failed = true
		} else {
			ars_hideLoader(ars_currentLoader, withCompletionBlock: completionBlock)
		}
	}
	
	// MARK: Configs & Animations
	
	func ars_launchTimer() {
		ars_dispatchAfter(0.01) {
			guard let strongSelf = ARSProgressLoader.weakSelf else { return }
			
			strongSelf.ars_incrementCircleRadius()
			strongSelf.ars_launchTimer()
		}
	}
	
	func ars_incrementCircleRadius() {
		if ars_didIncrementMultiplier() == false { return }
		
		ars_drawCirclePath()
		
		if failed && multiplier <= 0.0 {
			ARSProgressLoader.weakSelf = nil
			multiplier = 0.01
			ars_drawCirclePath()
			ars_failedLoading()
		} else if multiplier >= 100 {
			ARSProgressLoader.weakSelf = nil
			ars_completed()
		}
	}
	
	func ars_drawCirclePath() {
		let viewBounds = backgroundView.bounds
		let center = CGPoint(x: viewBounds.midX, y: viewBounds.midY)
		let endAngle = CGFloat.pi / 180 * 3.6 * multiplier
		let outerPath = UIBezierPath(arcCenter: center, radius: ARS_CIRCLE_RADIUS_OUTER, startAngle: 0, endAngle: endAngle, clockwise: true)
		let middlePath = UIBezierPath(arcCenter: center, radius: ARS_CIRCLE_RADIUS_MIDDLE, startAngle: 0, endAngle: endAngle, clockwise: true)
		let innerPath = UIBezierPath(arcCenter: center, radius: ARS_CIRCLE_RADIUS_INNER, startAngle: 0, endAngle: endAngle, clockwise: true)
		
		self.outerCircle.path = outerPath.cgPath
		self.middleCircle.path = middlePath.cgPath
		self.innerCircle.path = innerPath.cgPath
	}
	
	func ars_didIncrementMultiplier() -> Bool {
		if failed {
			multiplier -= 1.5
			return true
		}
		
		let progress: CGFloat = ars_progressSource()
		if lastMultiplierValue == progress { return false }
		
		if progress / multiplier > 2 {
			if multiplier < progress {
				multiplier += 0.75
			}
		} else {
			if multiplier < progress {
				multiplier += 0.25
			}
		}
		lastMultiplierValue = multiplier
		
		return true
	}
	
	func ars_progressSource() -> CGFloat {
		if let progress = self.progress {
			return CGFloat(progress.fractionCompleted * 100.0)
		} else {
			return progressValue
		}
	}
	
	func ars_completed() {
		let transform = CATransform3DMakeScale(0.01, 0.01, 1)
		
		CATransaction.begin()
		CATransaction.setAnimationDuration(0.5)
		CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0.70, -0.80, 0.68, 0.95))
		self.innerCircle.transform = transform
		CATransaction.begin()
		CATransaction.setAnimationDuration(0.7)
		self.middleCircle.transform = transform
		CATransaction.begin()
		CATransaction.setAnimationDuration(0.9)
		self.outerCircle.transform = transform
		CATransaction.commit()
		CATransaction.commit()
		CATransaction.commit()
		
		ars_dispatchAfter(0.9) {
			if ARSLineProgressConfiguration.showSuccessCheckmark {
				ARSStatus.show(.success)
				
				let dismissDelay = 0.5 + max(ARSLineProgressConfiguration.successCircleAnimationDrawDuration, ARSLineProgressConfiguration.checkmarkAnimationDrawDuration)
				
				ars_dispatchAfter(dismissDelay) {
					ars_hideLoader(ars_currentLoader, withCompletionBlock: ars_currentCompletionBlock)
				}
			} else {
				ars_hideLoader(ars_currentLoader, withCompletionBlock: ars_currentCompletionBlock)
			}
		}
	}
	
	func ars_failedLoading() {
		ARSStatus.show(.fail)
		let dismissDelay = 0.5 + max(ARSLineProgressConfiguration.failCircleAnimationDrawDuration, ARSLineProgressConfiguration.failCrossAnimationDrawDuration)
		
		ars_dispatchAfter(dismissDelay) {
			ars_hideLoader(ars_currentLoader, withCompletionBlock: ars_currentCompletionBlock)
		}
	}
	
}
