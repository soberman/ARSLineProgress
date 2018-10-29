//
//  ARSLineProgressHelpers.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 09/10/2016.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//
//  Website: http://arsenkin.com
//

import UIKit


enum ARSLoaderType {
	case infinite
	case progress
}

public enum BackgroundStyle {
	case blur
	case simple
	case full
}

func ars_window() -> UIWindow? {
	var targetWindow: UIWindow?
	let windows = UIApplication.shared.windows
	for window in windows {
		if window.screen != UIScreen.main { continue }
		if !window.isHidden && window.alpha == 0 { continue }
		if window.windowLevel != UIWindow.Level.normal { continue }
		
		targetWindow = window
		break
	}
	
	return targetWindow
}

@discardableResult func ars_createdFrameForBackgroundView(_ backgroundView: UIView, onView view: UIView?) -> Bool {
	let center: CGPoint
	let bounds: CGRect
	
	if view == nil {
		guard let window = ars_window() else { return false }
		bounds = window.screen.bounds
	} else {
		bounds = view!.bounds
	}
	
	center = CGPoint(x: bounds.midX, y: bounds.midY)
	
	let sideLengths = ARS_BACKGROUND_VIEW_SIDE_LENGTH
	
	switch ars_config.backgroundViewStyle {
	case .blur, .simple:
		backgroundView.frame = CGRect(x: center.x - sideLengths / 2, y: center.y - sideLengths / 2, width: sideLengths, height: sideLengths)
		backgroundView.layer.cornerRadius = ars_config.backgroundViewCornerRadius
	case .full:
		backgroundView.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
		backgroundView.layer.cornerRadius = 0
	}
	
	backgroundView.backgroundColor = UIColor(cgColor: ars_config.backgroundViewColor)
	
	return true
}

class ARSBlurredBackgroundRect {
	
	var view: UIVisualEffectView
	
	init() {
		let blur = UIBlurEffect(style: ars_config.blurStyle)
		let effectView = UIVisualEffectView(effect: blur)
		effectView.clipsToBounds = true
		
		view = effectView
	}
	
}

class ARSSimpleBackgroundRect {
	
	var view: UIView
	
	init() {
		let simpleView = UIView()
		simpleView.backgroundColor = UIColor(cgColor: ars_config.backgroundViewColor)
		
		view = simpleView
	}
}

class ARSFullBackgroundRect {
	
	var view: UIView
	
	init() {
		let fullView = UIView()
		fullView.backgroundColor = UIColor(cgColor: ars_config.backgroundViewColor)
		
		view = fullView
	}
}

func ars_createCircles(_ outerCircle: CAShapeLayer, middleCircle: CAShapeLayer, innerCircle: CAShapeLayer, onView view: UIView, loaderType: ARSLoaderType) {
	let circleRadiusOuter = ARS_CIRCLE_RADIUS_OUTER
	let circleRadiusMiddle = ARS_CIRCLE_RADIUS_MIDDLE
	let circleRadiusInner = ARS_CIRCLE_RADIUS_INNER
	let viewBounds = view.bounds
	let arcCenter = CGPoint(x: viewBounds.midX, y: viewBounds.midY)
	var path: UIBezierPath
	
	switch loaderType {
	case .infinite:
		path = UIBezierPath(arcCenter: arcCenter,
		                    radius: circleRadiusOuter,
		                    startAngle: ARS_CIRCLE_START_ANGLE,
		                    endAngle: ARS_CIRCLE_END_ANGLE,
		                    clockwise: true)
	case .progress:
		path = UIBezierPath(arcCenter: arcCenter,
		                    radius: circleRadiusOuter,
		                    startAngle: 0,
		                    endAngle: CGFloat.pi / 180 * 3.6 * 1,
		                    clockwise: true)
	}
	ars_configureLayer(outerCircle, forView: view, withPath: path.cgPath, withBounds: viewBounds, withColor: ars_config.circleColorOuter)
	
	switch loaderType {
	case .infinite:
		path = UIBezierPath(arcCenter: arcCenter,
		                    radius: circleRadiusMiddle,
		                    startAngle: ARS_CIRCLE_START_ANGLE,
		                    endAngle: ARS_CIRCLE_END_ANGLE,
		                    clockwise: true)
	case .progress:
		path = UIBezierPath(arcCenter: arcCenter,
		                    radius: circleRadiusMiddle,
		                    startAngle: 0,
		                    endAngle: CGFloat.pi / 180 * 3.6 * 1,
		                    clockwise: true)
	}
	ars_configureLayer(middleCircle, forView: view, withPath: path.cgPath, withBounds: viewBounds, withColor: ars_config.circleColorMiddle)
	
	switch loaderType {
	case .infinite:
		path = UIBezierPath(arcCenter: arcCenter,
		                    radius: circleRadiusInner,
		                    startAngle: ARS_CIRCLE_START_ANGLE,
		                    endAngle: ARS_CIRCLE_END_ANGLE,
		                    clockwise: true)
	case .progress:
		path = UIBezierPath(arcCenter: arcCenter,
		                    radius: circleRadiusInner,
		                    startAngle: 0,
		                    endAngle: CGFloat.pi / 180 * 3.6 * 1,
		                    clockwise: true)
	}
	ars_configureLayer(innerCircle, forView: view, withPath: path.cgPath, withBounds: viewBounds, withColor: ars_config.circleColorInner)
}

func ars_stopCircleAnimations(_ loader: ARSLoader, completionBlock: @escaping () -> Void) {
	
	CATransaction.begin()
	CATransaction.setAnimationDuration(0.25)
	CATransaction.setCompletionBlock(completionBlock)
	loader.outerCircle?.opacity = 0.0
	loader.middleCircle?.opacity = 0.0
	loader.innerCircle?.opacity = 0.0
	CATransaction.commit()
}

func ars_presentLoader(_ loader: ARSLoader, onView view: UIView?, completionBlock: (() -> Void)?) {
	ars_currentLoader = loader
	
	let emptyView = loader.emptyView
	emptyView.backgroundColor = .clear
	emptyView.frame = loader.backgroundView.bounds
	emptyView.addSubview(loader.backgroundView)
	
	ars_dispatchOnMainQueue {
		if let targetView = view {
			targetView.addSubview(emptyView)
		} else {
			ars_window()!.addSubview(emptyView)
		}
		
		CATransaction.begin()
		CATransaction.setCompletionBlock(completionBlock)
		
		let alphaAnimation = CABasicAnimation(keyPath: "opacity")
		alphaAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
		alphaAnimation.fromValue = 0
		alphaAnimation.toValue = 1
		alphaAnimation.duration = ars_config.backgroundViewPresentAnimationDuration
		
		emptyView.layer.removeAnimation(forKey: "alpha")
		emptyView.layer.add(alphaAnimation, forKey: "alpha")
		
		CATransaction.commit()
	}
}

func ars_hideLoader(_ loader: ARSLoader?, withCompletionBlock block: (() -> Void)?) {
	guard let loader = loader else { return }
	
	ars_dispatchOnMainQueue {
		
		let currentLayer = loader.emptyView.layer.presentation()
		
		let alpha = Double(currentLayer?.opacity ?? 0)
		let fixedTime = alpha * ars_config.backgroundViewDismissAnimationDuration
		
		CATransaction.begin()
		CATransaction.setCompletionBlock(block)
		let alphaAnimation = CABasicAnimation(keyPath: "opacity")
		alphaAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
		alphaAnimation.fromValue = alpha
		alphaAnimation.toValue = 0
		alphaAnimation.duration = fixedTime
		alphaAnimation.isRemovedOnCompletion = true
		
		loader.emptyView.layer.removeAnimation(forKey: "alpha")
		loader.emptyView.alpha = 0
		loader.emptyView.layer.add(alphaAnimation, forKey: "alpha")
		
		let scaleAnimation = CABasicAnimation(keyPath: "transform")
		scaleAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
		scaleAnimation.fromValue = CGAffineTransform(scaleX: 1, y: 1)
		scaleAnimation.toValue = CGAffineTransform(scaleX: ars_config.backgroundViewDismissTransformScale,
		                                           y: ars_config.backgroundViewDismissTransformScale)
		scaleAnimation.duration = fixedTime
		scaleAnimation.isRemovedOnCompletion = true
		
		loader.backgroundView.layer.removeAnimation(forKey: "transform")
		loader.backgroundView.layer.add(scaleAnimation, forKey: "transform")
	}
	
	ars_dispatchAfter(ars_config.backgroundViewDismissAnimationDuration) {
		ars_cleanupLoader(loader)
	}
}

func ars_configureLayer(_ layer: CAShapeLayer, forView view: UIView, withPath path: CGPath, withBounds bounds: CGRect, withColor color: CGColor) {
	layer.path = path
	layer.frame = bounds
	layer.lineWidth = ARS_CIRCLE_LINE_WIDTH
	layer.strokeColor = color
	layer.fillColor = UIColor.clear.cgColor
	layer.isOpaque = true
	view.layer.addSublayer(layer)
}

func ars_animateCircles(_ outerCircle: CAShapeLayer, middleCircle: CAShapeLayer, innerCircle: CAShapeLayer) {
	ars_dispatchOnMainQueue {
		let outerAnimation = CABasicAnimation(keyPath: "transform.rotation")
		outerAnimation.toValue = ARS_CIRCLE_ROTATION_TO_VALUE
		outerAnimation.duration = ars_config.circleRotationDurationOuter
		outerAnimation.repeatCount = ARS_CIRCLE_ROTATION_REPEAT_COUNT
		outerAnimation.isRemovedOnCompletion = false
		outerCircle.add(outerAnimation, forKey: "outerCircleRotation")
		
		let middleAnimation = outerAnimation.copy() as! CABasicAnimation
		middleAnimation.duration = ars_config.circleRotationDurationMiddle
		middleCircle.add(middleAnimation, forKey: "middleCircleRotation")
		
		let innerAnimation = middleAnimation.copy() as! CABasicAnimation
		innerAnimation.duration = ars_config.circleRotationDurationInner
		innerCircle.add(innerAnimation, forKey: "middleCircleRotation")
	}
}

func ars_cleanupLoader(_ loader: ARSLoader) {
	loader.emptyView.removeFromSuperview()
	ars_currentLoader = nil
	ars_currentCompletionBlock = nil
}

