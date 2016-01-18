//
//  ARSLineProgress.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 18.01.16.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//

import UIKit

public struct ARSLineProgress {}

// MARK: - Public Methods

public extension ARSLineProgress {
    
    static func show() {
        InfiniteLoader().show()
    }
    
    static func showOnView(view: UIView) {
        
    }
    
    static func hide() {
        
    }
    
}




// =====================================================================================================================
// MARK: - Private Infinite Loader
// =====================================================================================================================

private struct InfiniteLoader {
    
    let CIRCLE_LINE_WIDTH: CGFloat = 2.0
    let CIRCLE_RADIUS_OUTER: CGFloat = 40.0
    let CIRCLE_RADIUS_MIDDLE: CGFloat = 30.0
    let CIRCLE_RADIUS_INNER: CGFloat = 20.0
    let CIRCLE_ROTATION_DURATION_OUTER: CFTimeInterval = 3.0
    let CIRCLE_ROTATION_DURATION_MIDDLE: CFTimeInterval = 1.5
    let CIRCLE_ROTATION_DURATION_INNER: CFTimeInterval = 0.75
    let CIRCLE_START_ANGLE: CGFloat = -CGFloat(M_PI_2)
    let CIRCLE_ROTATION_TO_VALUE = 2 * CGFloat(M_PI)
    let CIRCLE_ROTATION_REPEAT_COUNT = Float(UINT64_MAX)
    let CIRCLE_END_ANGLE: CGFloat = 0.0
    var CIRCLE_COLOR_OUTER: CGColor {
        return UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
    }
    var CIRCLE_COLOR_MIDDLE: CGColor {
        return UIColor.gs_colorWithRGB(82.0, green: 124.0, blue: 194.0, alpha: 1.0).CGColor
    }
    var CIRCLE_COLOR_INNER: CGColor {
        return UIColor.gs_colorWithRGB(60.0, green: 132.0, blue: 196.0, alpha: 1.0).CGColor
    }
    var backgroundRect = UIView()
    var invisibleRect = UIView()
    var outerCircle = CAShapeLayer()
    var middleCircle = CAShapeLayer()
    var innerCircle = CAShapeLayer()
    var window: UIWindow? {
        var targetWindow: UIWindow?
        let windows = UIApplication.sharedApplication().windows
        for window in windows {
            if window.screen != UIScreen.mainScreen() { continue }
            if !window.hidden && window.alpha == 0 { continue }
            if window.windowLevel != UIWindowLevelNormal { continue }
            
            targetWindow = window
        }
        
        return targetWindow
    }
    
    init() {
        backgroundRect = createBluringViewWithStyle(.ExtraLight)
    }
    
}

private extension InfiniteLoader {
    
    func show() {
        if prepareObjects() == false { return }
        createCircles()
        animateCircles()
        present()
    }
    
    func prepareObjects() -> Bool {
        guard let window = self.window else { return false }
        let screenCenter = CGPointMake(CGRectGetMidX(window.screen.bounds), CGRectGetMidY(window.screen.bounds))
        backgroundRect.frame = CGRectMake(screenCenter.x - 50, screenCenter.y - 50, 100, 100)
        
        return true
    }
    
    func createCircles() {
        var path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: CIRCLE_RADIUS_OUTER, startAngle: CIRCLE_START_ANGLE, endAngle: CIRCLE_END_ANGLE, clockwise: true)
        outerCircle.path = path.CGPath
        outerCircle.frame = backgroundRect.bounds
        outerCircle.lineWidth = CIRCLE_LINE_WIDTH
        outerCircle.strokeColor = CIRCLE_COLOR_OUTER
        outerCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(outerCircle)
        
        path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: CIRCLE_RADIUS_MIDDLE, startAngle: CIRCLE_START_ANGLE, endAngle: CIRCLE_END_ANGLE, clockwise: true)
        middleCircle.path = path.CGPath
        middleCircle.frame = backgroundRect.bounds
        middleCircle.lineWidth = CIRCLE_LINE_WIDTH
        middleCircle.strokeColor = CIRCLE_COLOR_MIDDLE
        middleCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(middleCircle)
        
        path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: CIRCLE_RADIUS_INNER, startAngle: CIRCLE_START_ANGLE, endAngle: CIRCLE_END_ANGLE, clockwise: true)
        innerCircle.path = path.CGPath
        innerCircle.frame = backgroundRect.bounds
        innerCircle.lineWidth = CIRCLE_LINE_WIDTH
        innerCircle.strokeColor = CIRCLE_COLOR_INNER
        innerCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(innerCircle)
    }
    
    func animateCircles() {
        let outerAnimation = CABasicAnimation(keyPath: "transform.rotation")
        outerAnimation.toValue = CIRCLE_ROTATION_TO_VALUE
        outerAnimation.duration = CIRCLE_ROTATION_DURATION_OUTER
        outerAnimation.repeatCount = CIRCLE_ROTATION_REPEAT_COUNT
        outerCircle.addAnimation(outerAnimation, forKey: "outerCircleRotation")
        
        let middleAnimation = CABasicAnimation(keyPath: "transform.rotation")
        middleAnimation.toValue = CIRCLE_ROTATION_TO_VALUE
        middleAnimation.duration = CIRCLE_ROTATION_DURATION_MIDDLE
        middleAnimation.repeatCount = CIRCLE_ROTATION_REPEAT_COUNT
        middleCircle.addAnimation(middleAnimation, forKey: "middleCircleRotation")
        
        let innerAnimation = CABasicAnimation(keyPath: "transform.rotation")
        innerAnimation.toValue = CIRCLE_ROTATION_TO_VALUE
        innerAnimation.duration = CIRCLE_ROTATION_DURATION_INNER
        innerAnimation.repeatCount = CIRCLE_ROTATION_REPEAT_COUNT
        innerCircle.addAnimation(innerAnimation, forKey: "middleCircleRotation")
    }
    
    func present() {
        window!.addSubview(backgroundRect)
        backgroundRect.alpha = 0.1
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            self.backgroundRect.alpha = 1.0
        }, completion: nil)
    }
    
}

// MARK: Helpers

private extension InfiniteLoader {
    
    func createBluringViewWithStyle(style: UIBlurEffectStyle) -> UIVisualEffectView {
        let blur = UIBlurEffect(style: style)
        let viewWithBlurredBackground = UIVisualEffectView(effect: blur)
        let viewInducingVibrancy = UIVisualEffectView(effect: blur)
        viewInducingVibrancy.layer.cornerRadius = 20
        viewInducingVibrancy.clipsToBounds = true
        viewWithBlurredBackground.contentView.addSubview(viewInducingVibrancy)
        
        return viewInducingVibrancy
    }
    
}




// =====================================================================================================================
// MARK: - Extensions
// =====================================================================================================================




private extension UIColor {
    
    static func gs_colorWithRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
}