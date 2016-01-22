//
//  ARSLineProgress.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 18.01.16.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//
//  Website: http://arsenkin.com
//

import UIKit

public struct ARSLineProgress {

    // MARK: Show Infinite Loader
    
    static func show() {
        InfiniteLoader().showWithCompletionBlock(nil)
    }
    
    static func showWithCompetionBlock(block: () -> Void) {
        InfiniteLoader().showWithCompletionBlock(block)
    }
    
    static func showOnView(view: UIView) {
        
    }
    
    static func showOnView(view: UIView, completionBlock: () -> Void) {
        InfiniteLoader().showWithCompletionBlock(completionBlock)
    }
    
    // MARK: Show & Update Progress Loader
    
    static func showWithProgress(value: CGFloat) {
        ProgressLoader().show()
    }
    
    static func showWithProgress(value: CGFloat, onView: UIView) {
        
    }
    
    static func updateWithProgress(value: CGFloat) {
        
    }
    
    static func showWithProgressObject(progress: NSProgress) {
        
    }
    
    static func showWithProgressObject(progress: NSProgress, onView: UIView) {
        
    }
    
    // MARK: Hiding
    
    static func hide() {
        
    }
    
    static func hideWithCompletionBlock(block: () -> Void) {
        
    }

}





// =====================================================================================================================
// MARK: - Shared Constants
// =====================================================================================================================

private let BACKGROUND_VIEW_SIDE_LENGTH: CGFloat = 125.0
private let BACKGROUND_VIEW_BORDER_RADIUS:CGFloat = 20.0
private let BACKGROUND_VIEW_PRESENT_ANIMATION_DURATION = 0.3





// =====================================================================================================================
// MARK: - Infinite Loader
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
    var backgroundRect: UIView
    var invisibleRect = UIView()
    var outerCircle = CAShapeLayer()
    var middleCircle = CAShapeLayer()
    var innerCircle = CAShapeLayer()
    
    init() {
        backgroundRect = BlurredBackgroundRect().view
    }
    
}

private extension InfiniteLoader {
    
    func showWithCompletionBlock(block: (() -> Void)?) {
        if prepareObjects() == false { return }
        createCircles()
        animateCircles()
        presentWithCompletionBlock(block)
    }
    
    func prepareObjects() -> Bool {
        guard let window = window() else { return false }
        let screenCenter = CGPointMake(CGRectGetMidX(window.screen.bounds), CGRectGetMidY(window.screen.bounds))
        backgroundRect.frame = CGRectMake(screenCenter.x - BACKGROUND_VIEW_SIDE_LENGTH / 2, screenCenter.y - BACKGROUND_VIEW_SIDE_LENGTH / 2, BACKGROUND_VIEW_SIDE_LENGTH, BACKGROUND_VIEW_SIDE_LENGTH)
        
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
    
    func presentWithCompletionBlock(block: (() -> Void)?) {
        window()!.addSubview(backgroundRect)
        backgroundRect.alpha = 0.1
        UIView.animateWithDuration(BACKGROUND_VIEW_PRESENT_ANIMATION_DURATION, delay: 0.0, options: .CurveEaseOut, animations: {
            self.backgroundRect.alpha = 1.0
        }, completion: { _ in block })
    }
    
}





// =====================================================================================================================
// MARK: - Progress Loader
// =====================================================================================================================

private struct ProgressLoader {
    
    var backgroundRect: UIView
    var outerCircle = CAShapeLayer()
    var middleCircle = CAShapeLayer()
    var innerCircle = CAShapeLayer()
    var multiplier: CGFloat = 1.0
    var progress: CGFloat = 0.0
    var timer = NSTimer()
    
    init() {
        backgroundRect = BlurredBackgroundRect().view
    }
    
}

private extension ProgressLoader {
    
    func show() {
        createBackgroundRect()
        createCircles()
        animateCircles()
    }
    
    func createBackgroundRect() {
//        let screenCenter = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
//        backgroundRect.frame = CGRectMake(screenCenter.x - 62.5, screenCenter.y - 62.5, 125, 125)
//        backgroundRect.backgroundColor = UIColor.whiteColor()
//        backgroundRect.layer.cornerRadius = 20
//        view.addSubview(backgroundRect)
    }
    
    func createCircles() {
        createOuterCircle()
        createMiddleCircle()
        createInnerCircle()
    }
    
    func createOuterCircle() {
        let path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 40.0, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * multiplier, clockwise: true)
        outerCircle.path = path.CGPath
        outerCircle.frame = backgroundRect.bounds
        outerCircle.lineWidth = 2.0
        outerCircle.strokeColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        outerCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(outerCircle)
    }
    
    func createMiddleCircle() {
        let path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 30.0, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * multiplier, clockwise: true)
        middleCircle.path = path.CGPath
        middleCircle.frame = backgroundRect.bounds
        middleCircle.lineWidth = 2.0
        middleCircle.strokeColor = UIColor.gs_colorWithRGB(82.0, green: 124.0, blue: 194.0, alpha: 1.0).CGColor
        middleCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(middleCircle)
    }
    
    func createInnerCircle() {
        let path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 20.0, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * multiplier, clockwise: true)
        innerCircle.path = path.CGPath
        innerCircle.frame = backgroundRect.bounds
        innerCircle.lineWidth = 2.0
        innerCircle.strokeColor = UIColor.gs_colorWithRGB(60.0, green: 132.0, blue: 196.0, alpha: 1.0).CGColor
        innerCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(innerCircle)
    }
    
    func animateCircles() {
        let outerAnimation = CABasicAnimation(keyPath: "transform.rotation")
        outerAnimation.fromValue = 0.0
        outerAnimation.toValue = 2 * CGFloat(M_PI)
        outerAnimation.duration = 3.0
        outerAnimation.repeatCount = 100
        outerAnimation.additive = true
        outerCircle.addAnimation(outerAnimation, forKey: "outerCircleRotation")
        
        let middleAnimation = CABasicAnimation(keyPath: "transform.rotation")
        middleAnimation.fromValue = 0.0
        middleAnimation.toValue = 2 * CGFloat(M_PI)
        middleAnimation.duration = 1.5
        middleAnimation.repeatCount = 100
        middleAnimation.additive = true
        middleCircle.addAnimation(middleAnimation, forKey: "middleCircleRotation")
        
        let innerAnimation = CABasicAnimation(keyPath: "transform.rotation")
        innerAnimation.fromValue = 0.0
        innerAnimation.toValue = 2 * CGFloat(M_PI)
        innerAnimation.duration = 0.75
        innerAnimation.repeatCount = 100
        innerAnimation.additive = true
        innerCircle.addAnimation(innerAnimation, forKey: "middleCircleRotation")
    }
    
    func completed() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0.70, -0.80, 0.68, 0.95))
        self.innerCircle.transform = CATransform3DMakeScale(0.01, 0.01, 1)
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.7)
        self.middleCircle.transform = CATransform3DMakeScale(0.01, 0.01, 1)
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.9)
        self.outerCircle.transform = CATransform3DMakeScale(0.01, 0.01, 1)
        CATransaction.commit()
        CATransaction.commit()
        CATransaction.commit()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.9 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.showSuccess()
            //            self.showFail()
        })
    }
    
    func dismiss() {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.backgroundRect.transform = CGAffineTransformMakeScale(0.9, 0.9)
            self.backgroundRect.alpha = 0.0
        }
    }
    
    func showSuccess() {
        let checkmarkPath = UIBezierPath()
        checkmarkPath.moveToPoint(CGPointMake(CGRectGetWidth(self.outerCircle.bounds) * 0.28, CGRectGetHeight(self.outerCircle.bounds) * 0.53))
        checkmarkPath.addLineToPoint(CGPointMake(CGRectGetWidth(self.outerCircle.bounds) * 0.42, CGRectGetHeight(self.outerCircle.bounds) * 0.66))
        checkmarkPath.addLineToPoint(CGPointMake(CGRectGetWidth(self.outerCircle.bounds) * 0.72, CGRectGetHeight(self.outerCircle.bounds) * 0.36))
        checkmarkPath.lineCapStyle = .Square
        
        let checkmark = CAShapeLayer()
        checkmark.path = checkmarkPath.CGPath
        checkmark.fillColor = nil
        checkmark.strokeColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        checkmark.lineWidth = 2.0
        self.backgroundRect.layer.addSublayer(checkmark)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.removedOnCompletion = true
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = kCAFillModeBoth
        animation.duration = 0.4
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        checkmark.addAnimation(animation, forKey: nil)
        
        let successCircle = CAShapeLayer(layer: outerCircle)
        successCircle.path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 40.0, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI) / 180 * 270, clockwise: true).CGPath
        successCircle.fillColor = nil
        successCircle.strokeColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        successCircle.lineWidth = 2.0
        backgroundRect.layer.addSublayer(successCircle)
        
        let animationCircle = CABasicAnimation(keyPath: "strokeEnd")
        animationCircle.removedOnCompletion = true
        animationCircle.fromValue = 0
        animationCircle.toValue = 1
        animationCircle.fillMode = kCAFillModeBoth
        animationCircle.duration = 0.7
        animationCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        successCircle.addAnimation(animationCircle, forKey: nil)
    }
    
    func showFail() {
        let crossPath = UIBezierPath()
        crossPath.moveToPoint(CGPointMake(CGRectGetWidth(outerCircle.bounds) * 0.67, CGRectGetHeight(outerCircle.bounds) * 0.32))
        crossPath.addLineToPoint(CGPointMake(CGRectGetWidth(outerCircle.bounds) * 0.32, CGRectGetHeight(outerCircle.bounds) * 0.67))
        crossPath.moveToPoint(CGPointMake(CGRectGetWidth(outerCircle.bounds) * 0.32, CGRectGetHeight(outerCircle.bounds) * 0.32))
        crossPath.addLineToPoint(CGPointMake(CGRectGetWidth(outerCircle.bounds) * 0.67, CGRectGetHeight(outerCircle.bounds) * 0.67))
        crossPath.lineCapStyle = .Square
        
        let cross = CAShapeLayer()
        cross.path = crossPath.CGPath
        cross.fillColor = nil
        cross.strokeColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        cross.lineWidth = 2.0
        cross.frame = backgroundRect.bounds
        backgroundRect.layer.addSublayer(cross)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.removedOnCompletion = false
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.4
        animation.fillMode = kCAFillModeBoth
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        cross.addAnimation(animation, forKey: nil)
        
        
        let failCircle = CAShapeLayer(layer: outerCircle)
        failCircle.path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 40.0, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI) / 180 * 270, clockwise: true).CGPath
        failCircle.fillColor = nil
        failCircle.strokeColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        failCircle.lineWidth = 2.0
        backgroundRect.layer.addSublayer(failCircle)
        
        let animationCircle = CABasicAnimation(keyPath: "opacity")
        animationCircle.removedOnCompletion = true
        animationCircle.fromValue = 0
        animationCircle.toValue = 1
        animationCircle.fillMode = kCAFillModeBoth
        animationCircle.duration = 0.7
        animationCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        failCircle.addAnimation(animationCircle, forKey: nil)
        
    }
    
    mutating func incrementMultiplier() {
        if multiplier >= 100 {
            timer.invalidate()
            completed()
            return
        }
        if progress / multiplier > 2 {
            if multiplier < progress {
                multiplier += 0.75
            }
        } else {
            if multiplier < progress {
                multiplier += 0.25
            }
        }
        
        let oPath = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 40.0, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * multiplier, clockwise: true)
        let mPath = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 30.0, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * multiplier, clockwise: true)
        let iPath = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 20.0, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * multiplier, clockwise: true)
        
        self.outerCircle.path = oPath.CGPath
        self.middleCircle.path = mPath.CGPath
        self.innerCircle.path = iPath.CGPath
    }
    
}





// =====================================================================================================================
// MARK: - Background Rect
// =====================================================================================================================

private struct BlurredBackgroundRect {
    
    var view: UIView
    
    init(style: UIBlurEffectStyle) {
        view = UIView()
        updateView(style, vibrancy: true)
    }
    
    init(vibrancy: Bool) {
        view = UIView()
        updateView(.ExtraLight, vibrancy: vibrancy)
    }
    
    init(style: UIBlurEffectStyle = .ExtraLight, vibrancy: Bool = true) {
        view = UIView()
        updateView(style, vibrancy: vibrancy)
    }
    
}

private extension BlurredBackgroundRect {
    
    mutating func updateView(style: UIBlurEffectStyle, vibrancy: Bool) {
        let blur = UIBlurEffect(style: style)
        let effectView = UIVisualEffectView(effect: blur)
        
        if vibrancy {
            let viewInducingVibrancy = UIVisualEffectView(effect: blur)
            viewInducingVibrancy.layer.cornerRadius = BACKGROUND_VIEW_BORDER_RADIUS
            viewInducingVibrancy.clipsToBounds = true
            effectView.contentView.addSubview(viewInducingVibrancy)
        }
        
        view = effectView.contentView
    }
    
}





// =====================================================================================================================
// MARK: - Extensions & Helpers & Class Constants & Shared Methods
// =====================================================================================================================

private func window() -> UIWindow? {
    var targetWindow: UIWindow?
    let windows = UIApplication.sharedApplication().windows
    for window in windows {
        if window.screen != UIScreen.mainScreen() { continue }
        if !window.hidden && window.alpha == 0 { continue }
        if window.windowLevel != UIWindowLevelNormal { continue }
        
        targetWindow = window
        break
    }
    
    return targetWindow
}

private extension UIColor {
    
    static func gs_colorWithRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
}