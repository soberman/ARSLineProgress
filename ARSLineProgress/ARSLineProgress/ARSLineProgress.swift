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

final class ARSLineProgress {
    
    // MARK: Show Infinite Loader
    
    static func show() {
        InfiniteLoader().showOnView(nil, completionBlock: nil)
    }
    
    static func showWithCompetionBlock(block: () -> Void) {
        InfiniteLoader().showOnView(nil, completionBlock: block)
    }
    
    static func showOnView(view: UIView) {
        InfiniteLoader().showOnView(view, completionBlock: nil)
    }
    
    static func showOnView(view: UIView, completionBlock: () -> Void) {
        InfiniteLoader().showOnView(view, completionBlock: completionBlock)
    }
    
    // MARK: Show Progress Loader
    
    static func showWithProgress(value: CGFloat) {
        ProgressLoader().showWithValue(value, onView: nil, completionBlock: nil)
    }
    
    static func showWithProgress(value: CGFloat, onView: UIView) {
        ProgressLoader().showWithValue(value, onView: onView, completionBlock: nil)
    }
    
    static func showWithProgress(value: CGFloat, completionBlock: (() -> Void)?) {
        ProgressLoader().showWithValue(value, onView: nil, completionBlock: completionBlock)
    }
    
    static func showWithProgress(value: CGFloat, onView: UIView, completionBlock: (() -> Void)?) {
        ProgressLoader().showWithValue(value, onView: onView, completionBlock: completionBlock)
    }
    
    // MARK: Update Progress Loader
    
    static func updateWithProgress(value: CGFloat) {
        ProgressLoader.weakSelf?.progress = value
    }
    
    static func showWithProgressObject(progress: NSProgress) {
        
    }
    
    static func showWithProgressObject(progress: NSProgress, onView: UIView) {
        
    }
    
    // MARK: Hide Loader
    
    static func hide() {
        currentLoader?.hideWithCompletionBlock(nil)
    }
    
    static func hideWithCompletionBlock(block: () -> Void) {
        currentLoader?.hideWithCompletionBlock(block)
    }
    
}




// =====================================================================================================================
// MARK: - Protocols & Enums
// =====================================================================================================================

private protocol Appearable {
    func presentOnView(view: UIView?, completionBlock: (() -> Void)?)
    func hideWithCompletionBlock(block: (() -> Void)?)
}

private enum LoaderType {
    case Infinite
    case Progress
}




// =====================================================================================================================
// MARK: - Shared Constants
// =====================================================================================================================

private let BACKGROUND_VIEW_SIDE_LENGTH: CGFloat = 125.0
private let BACKGROUND_VIEW_CORNER_RADIUS:CGFloat = 20.0
private let BACKGROUND_VIEW_PRESENT_ANIMATION_DURATION = 0.3

private let CIRCLE_ROTATION_DURATION_OUTER: CFTimeInterval = 3.0
private let CIRCLE_ROTATION_DURATION_MIDDLE: CFTimeInterval = 1.5
private let CIRCLE_ROTATION_DURATION_INNER: CFTimeInterval = 0.75
private let CIRCLE_ROTATION_TO_VALUE = 2 * CGFloat(M_PI)
private let CIRCLE_ROTATION_REPEAT_COUNT = Float(UINT64_MAX)

private let CIRCLE_LINE_WIDTH: CGFloat = 2.0
private let CIRCLE_RADIUS_OUTER: CGFloat = 40.0
private let CIRCLE_RADIUS_MIDDLE: CGFloat = 30.0
private let CIRCLE_RADIUS_INNER: CGFloat = 20.0
private let CIRCLE_START_ANGLE: CGFloat = -CGFloat(M_PI_2)
private let CIRCLE_END_ANGLE: CGFloat = 0.0
private var CIRCLE_COLOR_OUTER: CGColor {
    return UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
}
private var CIRCLE_COLOR_MIDDLE: CGColor {
    return UIColor.gs_colorWithRGB(82.0, green: 124.0, blue: 194.0, alpha: 1.0).CGColor
}
private var CIRCLE_COLOR_INNER: CGColor {
    return UIColor.gs_colorWithRGB(60.0, green: 132.0, blue: 196.0, alpha: 1.0).CGColor
}

private var currentLoader: Appearable?




// =====================================================================================================================
// MARK: - Infinite Loader
// =====================================================================================================================

private final class InfiniteLoader: Appearable {
    
    var backgroundView: UIVisualEffectView
    var invisibleRect = UIView()
    var outerCircle = CAShapeLayer()
    var middleCircle = CAShapeLayer()
    var innerCircle = CAShapeLayer()
    
    init() {
        backgroundView = BlurredBackgroundRect().view
    }
    
    func presentOnView(view: UIView?, completionBlock: (() -> Void)?) {
        currentLoader = self
        window()!.addSubview(backgroundView)
        backgroundView.alpha = 0.1
        UIView.animateWithDuration(BACKGROUND_VIEW_PRESENT_ANIMATION_DURATION, delay: 0.0, options: .CurveEaseOut, animations: {
            self.backgroundView.alpha = 1.0
            }, completion: { _ in completionBlock })
    }
    
    func hideWithCompletionBlock(block: (() -> Void)?) {
        currentLoader = nil
        UIView.animateWithDuration(BACKGROUND_VIEW_PRESENT_ANIMATION_DURATION, delay: 0.0, options: .CurveEaseOut, animations: {
            self.backgroundView.alpha = 0.0
            self.backgroundView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: { _ in block })
    }
    
}

private extension InfiniteLoader {
    
    func showOnView(view: UIView?, completionBlock: (() -> Void)?) {
        if createdFrameForBackgroundView(backgroundView, onView: view) == false { return }
        
        createCircles(outerCircle: outerCircle,
            middleCircle: middleCircle,
            innerCircle: innerCircle,
            onView: backgroundView.contentView,
            loaderType: .Infinite)
        animateCircles(outerCircle: outerCircle, middleCircle: middleCircle, innerCircle: innerCircle)
        presentOnView(view, completionBlock: completionBlock)
    }
    
}




// =====================================================================================================================
// MARK: - Progress Loader
// =====================================================================================================================

private final class ProgressLoader: Appearable {
    
    static weak var weakSelf: ProgressLoader?
    
    var backgroundView: UIVisualEffectView
    var outerCircle = CAShapeLayer()
    var middleCircle = CAShapeLayer()
    var innerCircle = CAShapeLayer()
    var multiplier: CGFloat = 1.0
    var progress: CGFloat = 0.0
    
    init() {
        backgroundView = BlurredBackgroundRect().view
        ProgressLoader.weakSelf = self
    }
    
    func presentOnView(view: UIView?, completionBlock: (() -> Void)?) {
        currentLoader = self
        window()!.addSubview(backgroundView)
        backgroundView.alpha = 0.1
        UIView.animateWithDuration(BACKGROUND_VIEW_PRESENT_ANIMATION_DURATION, delay: 0.0, options: .CurveEaseOut, animations: {
            self.backgroundView.alpha = 1.0
            }, completion: { _ in completionBlock })
    }
    
    func hideWithCompletionBlock(block: (() -> Void)?) {
        currentLoader = nil
        UIView.animateWithDuration(BACKGROUND_VIEW_PRESENT_ANIMATION_DURATION, delay: 0.0, options: .CurveEaseOut, animations: {
            self.backgroundView.alpha = 0.0
            self.backgroundView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: { _ in block })
    }
    
}

private extension ProgressLoader {
    
    func showWithValue(value: CGFloat, onView view: UIView?, completionBlock: (() -> Void)?) {
        if createdFrameForBackgroundView(backgroundView, onView: view) == false { return }
        
        createCircles(outerCircle: outerCircle, middleCircle: middleCircle, innerCircle: innerCircle, onView: backgroundView.contentView, loaderType: .Progress)
        animateCircles(outerCircle: outerCircle, middleCircle: middleCircle, innerCircle: innerCircle)
        presentOnView(view, completionBlock: completionBlock)
        launchTimer()
    }
    
    func launchTimer() {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.01 * Double(NSEC_PER_SEC)));
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            guard let strongSelf = ProgressLoader.weakSelf else { return }
            
            strongSelf.incrementCircleRadius()
            strongSelf.launchTimer()
        })
    }
    
    func incrementCircleRadius() {
        if self.progress >= 100 {
            ProgressLoader.weakSelf = nil
            completed()
            return
        }
        incrementMultiplier()
        
        let viewBounds = backgroundView.bounds
        let center = CGPointMake(CGRectGetMidX(viewBounds), CGRectGetMidY(viewBounds))
        let endAngle = CGFloat(M_PI) / 180 * 3.6 * multiplier
        let outerPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS_OUTER, startAngle: 0, endAngle: endAngle, clockwise: true)
        let middlePath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS_MIDDLE, startAngle: 0, endAngle: endAngle, clockwise: true)
        let innerPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS_INNER, startAngle: 0, endAngle: endAngle, clockwise: true)
        
        self.outerCircle.path = outerPath.CGPath
        self.middleCircle.path = middlePath.CGPath
        self.innerCircle.path = innerPath.CGPath
    }
    
    func incrementMultiplier() {
        if progress / multiplier > 2 {
            if multiplier < progress {
                multiplier += 0.75
            }
        } else {
            if multiplier < progress {
                multiplier += 0.25
            }
        }
    }
    
    func completed() {
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
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.9 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.showSuccess()
            //            self.showFail()
        })
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
        self.backgroundView.layer.addSublayer(checkmark)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.removedOnCompletion = true
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = kCAFillModeBoth
        animation.duration = 0.4
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        checkmark.addAnimation(animation, forKey: nil)
        
        let successCircle = CAShapeLayer(layer: outerCircle)
        successCircle.path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundView.bounds), CGRectGetMidY(backgroundView.bounds)), radius: 40.0, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI) / 180 * 270, clockwise: true).CGPath
        successCircle.fillColor = nil
        successCircle.strokeColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        successCircle.lineWidth = 2.0
        backgroundView.layer.addSublayer(successCircle)
        
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
        cross.frame = backgroundView.bounds
        backgroundView.layer.addSublayer(cross)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.removedOnCompletion = false
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.4
        animation.fillMode = kCAFillModeBoth
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        cross.addAnimation(animation, forKey: nil)
        
        
        let failCircle = CAShapeLayer(layer: outerCircle)
        failCircle.path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundView.bounds), CGRectGetMidY(backgroundView.bounds)), radius: 40.0, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI) / 180 * 270, clockwise: true).CGPath
        failCircle.fillColor = nil
        failCircle.strokeColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        failCircle.lineWidth = 2.0
        backgroundView.layer.addSublayer(failCircle)
        
        let animationCircle = CABasicAnimation(keyPath: "opacity")
        animationCircle.removedOnCompletion = true
        animationCircle.fromValue = 0
        animationCircle.toValue = 1
        animationCircle.fillMode = kCAFillModeBoth
        animationCircle.duration = 0.7
        animationCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        failCircle.addAnimation(animationCircle, forKey: nil)
        
    }
    
}




// =====================================================================================================================
// MARK: - Background Rect
// =====================================================================================================================

private struct BlurredBackgroundRect {
    
    var view: UIVisualEffectView
    
    init(style: UIBlurEffectStyle = .ExtraLight) {
        let blur = UIBlurEffect(style: .Light)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.clipsToBounds = true
        
        view = effectView
    }
    
}




// =====================================================================================================================
// MARK: - Extensions & Helpers & Shared Methods
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

private func createdFrameForBackgroundView(backgroundView: UIView, onView view: UIView?) -> Bool {
    let center: CGPoint
    
    if view == nil {
        guard let window = window() else { return false }
        center = CGPointMake(CGRectGetMidX(window.screen.bounds), CGRectGetMidY(window.screen.bounds))
    } else {
        let viewBounds = view!.bounds
        center = CGPointMake(CGRectGetMidX(viewBounds), CGRectGetMidY(viewBounds))
    }
    
    backgroundView.frame = CGRectMake(center.x - BACKGROUND_VIEW_SIDE_LENGTH / 2, center.y - BACKGROUND_VIEW_SIDE_LENGTH / 2, BACKGROUND_VIEW_SIDE_LENGTH, BACKGROUND_VIEW_SIDE_LENGTH)
    backgroundView.layer.cornerRadius = BACKGROUND_VIEW_CORNER_RADIUS
    
    return true
}

private func createCircles(outerCircle outerCircle: CAShapeLayer, middleCircle: CAShapeLayer, innerCircle: CAShapeLayer, onView view: UIView, loaderType: LoaderType) {
    let viewBounds = view.bounds
    let arcCenter = CGPointMake(CGRectGetMidX(viewBounds), CGRectGetMidY(viewBounds))
    var path: UIBezierPath
    
    switch loaderType {
    case .Infinite:
        path = UIBezierPath(arcCenter: arcCenter, radius: CIRCLE_RADIUS_OUTER, startAngle: CIRCLE_START_ANGLE, endAngle: CIRCLE_END_ANGLE, clockwise: true)
    case .Progress:
        path = UIBezierPath(arcCenter: arcCenter, radius: CIRCLE_RADIUS_OUTER, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * 1, clockwise: true)
    }
    configureLayer(outerCircle, forView: view, withPath: path.CGPath, withBounds: viewBounds, withColor: CIRCLE_COLOR_OUTER)
    
    switch loaderType {
    case .Infinite:
        path = UIBezierPath(arcCenter: arcCenter, radius: CIRCLE_RADIUS_MIDDLE, startAngle: CIRCLE_START_ANGLE, endAngle: CIRCLE_END_ANGLE, clockwise: true)
    case .Progress:
        path = UIBezierPath(arcCenter: arcCenter, radius: CIRCLE_RADIUS_MIDDLE, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * 1, clockwise: true)
    }
    configureLayer(middleCircle, forView: view, withPath: path.CGPath, withBounds: viewBounds, withColor: CIRCLE_COLOR_MIDDLE)
    
    switch loaderType {
    case .Infinite:
        path = UIBezierPath(arcCenter: arcCenter, radius: CIRCLE_RADIUS_INNER, startAngle: CIRCLE_START_ANGLE, endAngle: CIRCLE_END_ANGLE, clockwise: true)
    case .Progress:
        path = UIBezierPath(arcCenter: arcCenter, radius: CIRCLE_RADIUS_INNER, startAngle: 0, endAngle: CGFloat(M_PI) / 180 * 3.6 * 1, clockwise: true)
    }
    configureLayer(innerCircle, forView: view, withPath: path.CGPath, withBounds: viewBounds, withColor: CIRCLE_COLOR_INNER)
}

private func configureLayer(layer: CAShapeLayer, forView view: UIView, withPath path: CGPath, withBounds bounds: CGRect, withColor color: CGColor) {
    layer.path = path
    layer.frame = bounds
    layer.lineWidth = CIRCLE_LINE_WIDTH
    layer.strokeColor = color
    layer.fillColor = UIColor.clearColor().CGColor
    view.layer.addSublayer(layer)
}

private func animateCircles(outerCircle outerCircle: CAShapeLayer, middleCircle: CAShapeLayer, innerCircle: CAShapeLayer) {
    let outerAnimation = CABasicAnimation(keyPath: "transform.rotation")
    outerAnimation.toValue = CIRCLE_ROTATION_TO_VALUE
    outerAnimation.duration = CIRCLE_ROTATION_DURATION_OUTER
    outerAnimation.repeatCount = CIRCLE_ROTATION_REPEAT_COUNT
    outerCircle.addAnimation(outerAnimation, forKey: "outerCircleRotation")
    
    let middleAnimation = outerAnimation.copy() as! CABasicAnimation
    middleAnimation.duration = CIRCLE_ROTATION_DURATION_MIDDLE
    middleCircle.addAnimation(middleAnimation, forKey: "middleCircleRotation")
    
    let innerAnimation = middleAnimation.copy() as! CABasicAnimation
    innerAnimation.duration = CIRCLE_ROTATION_DURATION_INNER
    innerCircle.addAnimation(innerAnimation, forKey: "middleCircleRotation")
}

private extension UIColor {
    
    static func gs_colorWithRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
}
