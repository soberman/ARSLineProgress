//
//  ARSStatus.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 09/10/2016.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//
//  Website: http://arsenkin.com
//

import UIKit

enum ARSStatusType {
	case success
	case fail
}

final class ARSStatus: ARSLoader {
	
	@objc var emptyView = UIView()
	@objc var backgroundView: UIVisualEffectView
	
	init() {
		backgroundView = ARSBlurredBackgroundRect().view
		ars_createdFrameForBackgroundView(backgroundView, onView: nil)
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
	
	static func show(_ type: ARSStatusType) {
		if let loader = ars_currentLoader {
			ars_stopCircleAnimations(loader, completionBlock: {
				drawStatus(type, loader: loader)
			})
		} else {
			let loader = ARSStatus()
			ars_presentLoader(loader, onView: nil, completionBlock: {
				drawStatus(type, loader: loader)
			})
		}
	}
	
	static func drawStatus(_ type: ARSStatusType, loader: ARSLoader) {
		ars_currentStatus = loader
		
		switch type {
		case .success:
			ARSStatus.drawSuccess(loader.backgroundView)
		case .fail:
			ARSStatus.drawFail(loader.backgroundView)
		}
		
		ars_dispatchAfter(1.25) {
			ars_hideLoader(loader, withCompletionBlock: nil)
		}
	}
	
}

extension ARSStatus {
	
	static func drawSuccess(_ backgroundView: UIVisualEffectView) {
		let backgroundViewBounds = backgroundView.bounds
		let backgroundLayer = backgroundView.layer
		let outerCircleHeight = backgroundViewBounds.height
		let outerCircleWidth = backgroundViewBounds.width
		
		let checkmarkPath = UIBezierPath()
		checkmarkPath.move(to: CGPoint(x: outerCircleWidth * 0.28, y: outerCircleHeight * 0.53))
		checkmarkPath.addLine(to: CGPoint(x: outerCircleWidth * 0.42, y: outerCircleHeight * 0.66))
		checkmarkPath.addLine(to: CGPoint(x: outerCircleWidth * 0.72, y: outerCircleHeight * 0.36))
		checkmarkPath.lineCapStyle = .square
		
		let checkmark = CAShapeLayer()
		checkmark.path = checkmarkPath.cgPath
		checkmark.fillColor = nil
		checkmark.strokeColor = ars_config.checkmarkColor
		checkmark.lineWidth = ars_config.checkmarkLineWidth
		backgroundLayer.addSublayer(checkmark)
		
		let successCircleArcCenter = CGPoint(x: backgroundViewBounds.midX, y: backgroundViewBounds.midY)
		let successCircle = CAShapeLayer()
		successCircle.path = UIBezierPath(arcCenter: successCircleArcCenter,
		                                  radius: ARS_CIRCLE_RADIUS_OUTER,
		                                  startAngle: -CGFloat(M_PI_2),
		                                  endAngle: CGFloat(M_PI) / 180 * 270,
		                                  clockwise: true).cgPath
		successCircle.fillColor = nil
		successCircle.strokeColor = ars_config.successCircleColor
		successCircle.lineWidth = ars_config.successCircleLineWidth
		backgroundLayer.addSublayer(successCircle)
		
		let animationCheckmark = CABasicAnimation(keyPath: "strokeEnd")
		animationCheckmark.isRemovedOnCompletion = true
		animationCheckmark.fromValue = 0
		animationCheckmark.toValue = 1
		animationCheckmark.fillMode = kCAFillModeBoth
		animationCheckmark.duration = ars_config.checkmarkAnimationDrawDuration
		animationCheckmark.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		checkmark.add(animationCheckmark, forKey: nil)
		
		let animationCircle = CABasicAnimation(keyPath: "strokeEnd")
		animationCircle.isRemovedOnCompletion = true
		animationCircle.fromValue = 0
		animationCircle.toValue = 1
		animationCircle.fillMode = kCAFillModeBoth
		animationCircle.duration = ars_config.successCircleAnimationDrawDuration
		animationCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		successCircle.add(animationCircle, forKey: nil)
	}
	
	static func drawFail(_ backgroundView: UIVisualEffectView) {
		let backgroundViewBounds = backgroundView.bounds
		let backgroundViewLayer = backgroundView.layer
		let outerCircleWidth = backgroundViewBounds.width
		let outerCircleHeight = backgroundViewBounds.height
		
		let crossPath = UIBezierPath()
		crossPath.move(to: CGPoint(x: outerCircleWidth * 0.67, y: outerCircleHeight * 0.32))
		crossPath.addLine(to: CGPoint(x: outerCircleWidth * 0.32, y: outerCircleHeight * 0.67))
		crossPath.move(to: CGPoint(x: outerCircleWidth * 0.32, y: outerCircleHeight * 0.32))
		crossPath.addLine(to: CGPoint(x: outerCircleWidth * 0.67, y: outerCircleHeight * 0.67))
		crossPath.lineCapStyle = .square
		
		let cross = CAShapeLayer()
		cross.path = crossPath.cgPath
		cross.fillColor = nil
		cross.strokeColor = ars_config.failCrossColor
		cross.lineWidth = ars_config.failCrossLineWidth
		cross.frame = backgroundViewBounds
		backgroundViewLayer.addSublayer(cross)
		
		let failCircleArcCenter = CGPoint(x: backgroundViewBounds.midX, y: backgroundViewBounds.midY)
		let failCircle = CAShapeLayer()
		failCircle.path = UIBezierPath(arcCenter: failCircleArcCenter,
		                               radius: ARS_CIRCLE_RADIUS_OUTER,
		                               startAngle: -CGFloat(M_PI_2),
		                               endAngle: CGFloat(M_PI) / 180 * 270,
		                               clockwise: true).cgPath
		failCircle.fillColor = nil
		failCircle.strokeColor = ars_config.failCircleColor
		failCircle.lineWidth = ars_config.failCircleLineWidth
		backgroundViewLayer.addSublayer(failCircle)
		
		let animationCross = CABasicAnimation(keyPath: "strokeEnd")
		animationCross.isRemovedOnCompletion = false
		animationCross.fromValue = 0
		animationCross.toValue = 1
		animationCross.duration = ars_config.failCrossAnimationDrawDuration
		animationCross.fillMode = kCAFillModeBoth
		animationCross.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
		cross.add(animationCross, forKey: nil)
		
		let animationCircle = CABasicAnimation(keyPath: "opacity")
		animationCircle.isRemovedOnCompletion = true
		animationCircle.fromValue = 0
		animationCircle.toValue = 1
		animationCircle.fillMode = kCAFillModeBoth
		animationCircle.duration = ars_config.failCircleAnimationDrawDuration
		animationCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		failCircle.add(animationCircle, forKey: nil)
	}
	
}
