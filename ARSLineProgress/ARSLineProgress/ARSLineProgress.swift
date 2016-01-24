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

public final class ARSLineProgress {
    
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
    
    static func showWithProgress(initialValue value: CGFloat) {
        ProgressLoader().showWithValue(value, onView: nil, progress: nil, completionBlock: nil)
    }
    
    static func showWithProgress(initialValue value: CGFloat, onView: UIView) {
        ProgressLoader().showWithValue(value, onView: onView, progress: nil, completionBlock: nil)
    }
    
    static func showWithProgress(initialValue value: CGFloat, completionBlock: (() -> Void)?) {
        ProgressLoader().showWithValue(value, onView: nil, progress: nil, completionBlock: completionBlock)
    }
    
    static func showWithProgress(initialValue value: CGFloat, onView: UIView, completionBlock: (() -> Void)?) {
        ProgressLoader().showWithValue(value, onView: onView, progress: nil, completionBlock: completionBlock)
    }
    
    static func showWithProgressObject(progress: NSProgress) {
        ProgressLoader().showWithValue(0.0, onView: nil, progress: progress, completionBlock: nil)
    }
    
    static func showWithProgressObject(progress: NSProgress, completionBlock: (() -> Void)?) {
        ProgressLoader().showWithValue(0.0, onView: nil, progress: progress, completionBlock: completionBlock)
    }
    
    static func showWithProgressObject(progress: NSProgress, onView: UIView) {
        ProgressLoader().showWithValue(0.0, onView: onView, progress: progress, completionBlock: nil)
    }
    
    static func showWithProgressObject(progress: NSProgress, onView: UIView, completionBlock: (() -> Void)?) {
        ProgressLoader().showWithValue(0.0, onView: onView, progress: progress, completionBlock: completionBlock)
    }
    
    // MARK: Update Progress Loader
    
    static func updateWithProgress(value: CGFloat) {
        ProgressLoader.weakSelf?.progressValue = value
    }
    
    // MARK: Hide Loader
    
    static func hide() {
        hideLoader(currentLoader, withCompletionBlock: nil)
    }
    
    static func hideWithCompletionBlock(block: () -> Void) {
        hideLoader(currentLoader, withCompletionBlock: block)
    }
    
}

public struct ARSLineProgressConfiguration {
    
    static var showSuccessCheckmark = true
    
    static var backgroundViewCornerRadius: CGFloat = 20.0
    static var backgroundViewPresentAnimationDuration: CFTimeInterval = 0.3
    static var backgroundViewDismissAnimationDuration: CFTimeInterval = 0.3
    
    static var blurStyle: UIBlurEffectStyle = .Light
    static var circleColorOuter: CGColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
    static var circleColorMiddle: CGColor = UIColor.gs_colorWithRGB(82.0, green: 124.0, blue: 194.0, alpha: 1.0).CGColor
    static var circleColorInner: CGColor = UIColor.gs_colorWithRGB(60.0, green: 132.0, blue: 196.0, alpha: 1.0).CGColor
    
    static var circleRotationDurationOuter: CFTimeInterval = 3.0
    static var circleRotationDurationMiddle: CFTimeInterval = 1.5
    static var circleRotationDurationInner: CFTimeInterval = 0.75
    
    static var checkmarkAnimationDrawDuration: CFTimeInterval = 0.4
    static var checkmarkLineWidth: CGFloat = 2.0
    static var checkmarkColor: CGColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
    
    static var successCircleAnimationDrawDuration: CFTimeInterval = 0.7
    static var successCircleLineWidth: CGFloat = 2.0
    static var successCircleColor: CGColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
    
    static var failCrossAnimationDrawDuration: CFTimeInterval = 0.4
    static var failCrossLineWidth: CGFloat = 2.0
    static var failCrossColor: CGColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
    
    static var failCircleAnimationDrawDuration: CFTimeInterval = 0.7
    static var failCircleLineWidth: CGFloat = 2.0
    static var failCircleColor: CGColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
    
    static func restoreDefaults() {
        config.showSuccessCheckmark = true
        
        config.backgroundViewCornerRadius = 20.0
        config.backgroundViewPresentAnimationDuration = 0.3
        config.backgroundViewDismissAnimationDuration = 0.3
        
        config.blurStyle = .Light
        config.circleColorOuter = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        config.circleColorMiddle = UIColor.gs_colorWithRGB(82.0, green: 124.0, blue: 194.0, alpha: 1.0).CGColor
        config.circleColorInner = UIColor.gs_colorWithRGB(60.0, green: 132.0, blue: 196.0, alpha: 1.0).CGColor
        
        config.circleRotationDurationOuter = 3.0
        config.circleRotationDurationMiddle = 1.5
        config.circleRotationDurationInner = 0.75
        
        config.checkmarkAnimationDrawDuration = 0.4
        config.checkmarkLineWidth = 2.0
        config.checkmarkColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        
        config.successCircleAnimationDrawDuration = 0.7
        config.successCircleLineWidth = 2.0
        config.successCircleColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        
        config.failCrossAnimationDrawDuration = 0.4
        config.failCrossLineWidth = 2.0
        config.failCrossColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        
        config.failCircleAnimationDrawDuration = 0.7
        config.failCircleLineWidth = 2.0
        config.failCircleColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
    }
    
}




// =====================================================================================================================
// MARK: - Protocols, Typealiases & Enums
// =====================================================================================================================

private typealias config = ARSLineProgressConfiguration

@objc private protocol Loader {
    var backgroundView: UIVisualEffectView { get set }
    optional func hideWithCompletionBlock(block: (() -> Void)?)
}

private enum LoaderType {
    case Infinite
    case Progress
}




// =====================================================================================================================
// MARK: - Shared Constants
// =====================================================================================================================

private let BACKGROUND_VIEW_SIDE_LENGTH: CGFloat = 125.0

private let CIRCLE_ROTATION_TO_VALUE = 2 * CGFloat(M_PI)
private let CIRCLE_ROTATION_REPEAT_COUNT = Float(UINT64_MAX)
private let CIRCLE_RADIUS_OUTER: CGFloat = 40.0
private let CIRCLE_RADIUS_MIDDLE: CGFloat = 30.0
private let CIRCLE_RADIUS_INNER: CGFloat = 20.0
private let CIRCLE_LINE_WIDTH: CGFloat = 2.0
private let CIRCLE_START_ANGLE: CGFloat = -CGFloat(M_PI_2)
private let CIRCLE_END_ANGLE: CGFloat = 0.0

private var currentLoader: Loader?
private var currentCompletionBlock: (() -> Void)?




// =====================================================================================================================
// MARK: - Infinite Loader
// =====================================================================================================================

private final class InfiniteLoader: Loader {
    
    @objc var backgroundView: UIVisualEffectView
    var invisibleRect = UIView()
    var outerCircle = CAShapeLayer()
    var middleCircle = CAShapeLayer()
    var innerCircle = CAShapeLayer()
    
    init() {
        backgroundView = BlurredBackgroundRect().view
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
        presentLoader(self, onView: view, completionBlock: completionBlock)
    }
    
}




// =====================================================================================================================
// MARK: - Progress Loader
// =====================================================================================================================

private final class ProgressLoader: Loader {
    
    @objc var backgroundView: UIVisualEffectView
    var outerCircle = CAShapeLayer()
    var middleCircle = CAShapeLayer()
    var innerCircle = CAShapeLayer()
    var multiplier: CGFloat = 1.0
    var lastMultiplierValue: CGFloat = 0.0
    var progressValue: CGFloat = 0.0
    var progress: NSProgress?
    static weak var weakSelf: ProgressLoader?
    
    init() {
        backgroundView = BlurredBackgroundRect().view
        ProgressLoader.weakSelf = self
    }
    
}

private extension ProgressLoader {
    
    func showWithValue(value: CGFloat, onView view: UIView?, progress: NSProgress?, completionBlock: (() -> Void)?) {
        if createdFrameForBackgroundView(backgroundView, onView: view) == false { return }
        if let progress = progress { self.progress = progress }
        
        createCircles(outerCircle: outerCircle,
            middleCircle: middleCircle,
            innerCircle: innerCircle,
            onView: backgroundView.contentView,
            loaderType: .Progress)
        animateCircles(outerCircle: outerCircle, middleCircle: middleCircle, innerCircle: innerCircle)
        presentLoader(self, onView: view, completionBlock: completionBlock)
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
        if didIncrementMultiplier() == false { return }
        
        let viewBounds = backgroundView.bounds
        let center = CGPointMake(CGRectGetMidX(viewBounds), CGRectGetMidY(viewBounds))
        let endAngle = CGFloat(M_PI) / 180 * 3.6 * multiplier
        let outerPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS_OUTER, startAngle: 0, endAngle: endAngle, clockwise: true)
        let middlePath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS_MIDDLE, startAngle: 0, endAngle: endAngle, clockwise: true)
        let innerPath = UIBezierPath(arcCenter: center, radius: CIRCLE_RADIUS_INNER, startAngle: 0, endAngle: endAngle, clockwise: true)
        
        self.outerCircle.path = outerPath.CGPath
        self.middleCircle.path = middlePath.CGPath
        self.innerCircle.path = innerPath.CGPath
        
        if multiplier >= 100 {
            ProgressLoader.weakSelf = nil
            completed()
        }
    }
    
    func didIncrementMultiplier() -> Bool {
        let progress: CGFloat = progressSource()
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
    
    func progressSource() -> CGFloat {
        if let progress = self.progress {
            return CGFloat(progress.fractionCompleted * 100.0)
        } else {
            return progressValue
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
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.9 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            if config.showSuccessCheckmark {
                self.showSuccess()
                
                let dismissDelay = 0.5 + 0.9 + max(config.successCircleAnimationDrawDuration, config.checkmarkAnimationDrawDuration)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(dismissDelay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                    hideLoader(currentLoader, withCompletionBlock: currentCompletionBlock)
                })
            } else {
                hideLoader(currentLoader, withCompletionBlock: currentCompletionBlock)
            }
        })
    }
    
    func showSuccess() {
        let backgroundViewBounds = backgroundView.bounds
        let backgroundLayer = backgroundView.layer
        let outerCircleBounds = self.outerCircle.bounds
        let outerCircleHeight = CGRectGetHeight(outerCircleBounds)
        let outerCircleWidth = CGRectGetWidth(outerCircleBounds)
        
        let checkmarkPath = UIBezierPath()
        checkmarkPath.moveToPoint(CGPointMake(outerCircleWidth * 0.28, outerCircleHeight * 0.53))
        checkmarkPath.addLineToPoint(CGPointMake(outerCircleWidth * 0.42, outerCircleHeight * 0.66))
        checkmarkPath.addLineToPoint(CGPointMake(outerCircleWidth * 0.72, outerCircleHeight * 0.36))
        checkmarkPath.lineCapStyle = .Square
        
        let checkmark = CAShapeLayer()
        checkmark.path = checkmarkPath.CGPath
        checkmark.fillColor = nil
        checkmark.strokeColor = config.checkmarkColor
        checkmark.lineWidth = config.checkmarkLineWidth
        backgroundLayer.addSublayer(checkmark)
        
        let successCircleArcCenter = CGPointMake(CGRectGetMidX(backgroundViewBounds), CGRectGetMidY(backgroundViewBounds))
        let successCircle = CAShapeLayer(layer: outerCircle)
        successCircle.path = UIBezierPath(arcCenter: successCircleArcCenter,
            radius: CIRCLE_RADIUS_OUTER,
            startAngle: -CGFloat(M_PI_2),
            endAngle: CGFloat(M_PI) / 180 * 270,
            clockwise: true).CGPath
        successCircle.fillColor = nil
        successCircle.strokeColor = config.successCircleColor
        successCircle.lineWidth = config.successCircleLineWidth
        backgroundLayer.addSublayer(successCircle)
        
        let animationCheckmark = CABasicAnimation(keyPath: "strokeEnd")
        animationCheckmark.removedOnCompletion = true
        animationCheckmark.fromValue = 0
        animationCheckmark.toValue = 1
        animationCheckmark.fillMode = kCAFillModeBoth
        animationCheckmark.duration = config.checkmarkAnimationDrawDuration
        animationCheckmark.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        checkmark.addAnimation(animationCheckmark, forKey: nil)
        
        let animationCircle = CABasicAnimation(keyPath: "strokeEnd")
        animationCircle.removedOnCompletion = true
        animationCircle.fromValue = 0
        animationCircle.toValue = 1
        animationCircle.fillMode = kCAFillModeBoth
        animationCircle.duration = config.successCircleAnimationDrawDuration
        animationCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        successCircle.addAnimation(animationCircle, forKey: nil)
    }
    
    func showFail() {
        let backgroundViewBounds = backgroundView.bounds
        let backgroundViewLayer = backgroundView.layer
        let outerCircleBounds = outerCircle.bounds
        let outerCircleWidth = CGRectGetWidth(outerCircleBounds)
        let outerCircleHeight = CGRectGetHeight(outerCircleBounds)
        
        let crossPath = UIBezierPath()
        crossPath.moveToPoint(CGPointMake(outerCircleWidth * 0.67, outerCircleHeight * 0.32))
        crossPath.addLineToPoint(CGPointMake(outerCircleWidth * 0.32, outerCircleHeight * 0.67))
        crossPath.moveToPoint(CGPointMake(outerCircleWidth * 0.32, outerCircleHeight * 0.32))
        crossPath.addLineToPoint(CGPointMake(outerCircleWidth * 0.67, outerCircleHeight * 0.67))
        crossPath.lineCapStyle = .Square
        
        let cross = CAShapeLayer()
        cross.path = crossPath.CGPath
        cross.fillColor = nil
        cross.strokeColor = config.failCrossColor
        cross.lineWidth = config.failCrossLineWidth
        cross.frame = backgroundViewBounds
        backgroundViewLayer.addSublayer(cross)
        
        let failCircleArcCenter = CGPointMake(CGRectGetMidX(backgroundViewBounds), CGRectGetMidY(backgroundViewBounds))
        let failCircle = CAShapeLayer(layer: outerCircle)
        failCircle.path = UIBezierPath(arcCenter: failCircleArcCenter,
            radius: CIRCLE_RADIUS_OUTER,
            startAngle: -CGFloat(M_PI_2),
            endAngle: CGFloat(M_PI) / 180 * 270,
            clockwise: true).CGPath
        failCircle.fillColor = nil
        failCircle.strokeColor = config.failCircleColor
        failCircle.lineWidth = config.failCircleLineWidth
        backgroundViewLayer.addSublayer(failCircle)
        
        let animationCross = CABasicAnimation(keyPath: "strokeEnd")
        animationCross.removedOnCompletion = false
        animationCross.fromValue = 0
        animationCross.toValue = 1
        animationCross.duration = config.failCrossAnimationDrawDuration
        animationCross.fillMode = kCAFillModeBoth
        animationCross.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        cross.addAnimation(animationCross, forKey: nil)
        
        let animationCircle = CABasicAnimation(keyPath: "opacity")
        animationCircle.removedOnCompletion = true
        animationCircle.fromValue = 0
        animationCircle.toValue = 1
        animationCircle.fillMode = kCAFillModeBoth
        animationCircle.duration = config.failCircleAnimationDrawDuration
        animationCircle.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        failCircle.addAnimation(animationCircle, forKey: nil)
        
    }
    
    func cleanup() {
        backgroundView.removeFromSuperview()
    }
    
}




// =====================================================================================================================
// MARK: - Background Rect
// =====================================================================================================================

private struct BlurredBackgroundRect {
    
    var view: UIVisualEffectView
    
    init() {
        let blur = UIBlurEffect(style: config.blurStyle)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.clipsToBounds = true
        
        view = effectView
    }
    
}




// =====================================================================================================================
// MARK: - Extensions & Helpers & Shared Methods
// =====================================================================================================================

private func presentLoader(loader: Loader, onView view: UIView?, completionBlock: (() -> Void)?) {
    currentLoader = loader
    currentCompletionBlock = completionBlock
    let backgroundView = loader.backgroundView
    
    if let targetView = view {
        targetView.addSubview(backgroundView)
    } else {
        window()!.addSubview(backgroundView)
    }
    backgroundView.alpha = 0.1
    UIView.animateWithDuration(config.backgroundViewPresentAnimationDuration, delay: 0.0, options: .CurveEaseOut, animations: {
        backgroundView.alpha = 1.0
    }, completion: { _ in completionBlock })
}

private func hideLoader(loader: Loader?, withCompletionBlock block: (() -> Void)?) {
    guard let loader = loader else { return }
    
    currentLoader = nil
    let backgroundView = loader.backgroundView
    
    UIView.animateWithDuration(config.backgroundViewDismissAnimationDuration, delay: 0.0, options: .CurveEaseOut, animations: {
        backgroundView.alpha = 0.0
        backgroundView.transform = CGAffineTransformMakeScale(0.9, 0.9)
    }, completion: { _ in block })
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(config.backgroundViewDismissAnimationDuration * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
        cleanupLoader(loader)
    })
}

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
    
    let sideLengths = BACKGROUND_VIEW_SIDE_LENGTH
    backgroundView.frame = CGRectMake(center.x - sideLengths / 2, center.y - sideLengths / 2, sideLengths, sideLengths)
    backgroundView.layer.cornerRadius = config.backgroundViewCornerRadius
    
    return true
}

private func createCircles(outerCircle outerCircle: CAShapeLayer, middleCircle: CAShapeLayer, innerCircle: CAShapeLayer, onView view: UIView, loaderType: LoaderType) {
    let circleRadiusOuter = CIRCLE_RADIUS_OUTER
    let circleRadiusMiddle = CIRCLE_RADIUS_MIDDLE
    let circleRadiusInner = CIRCLE_RADIUS_INNER
    let viewBounds = view.bounds
    let arcCenter = CGPointMake(CGRectGetMidX(viewBounds), CGRectGetMidY(viewBounds))
    var path: UIBezierPath
    
    switch loaderType {
    case .Infinite:
        path = UIBezierPath(arcCenter: arcCenter,
            radius: circleRadiusOuter,
            startAngle: CIRCLE_START_ANGLE,
            endAngle: CIRCLE_END_ANGLE,
            clockwise: true)
    case .Progress:
        path = UIBezierPath(arcCenter: arcCenter,
            radius: circleRadiusOuter,
            startAngle: 0, endAngle:
            CGFloat(M_PI) / 180 * 3.6 * 1,
            clockwise: true)
    }
    configureLayer(outerCircle, forView: view, withPath: path.CGPath, withBounds: viewBounds, withColor: config.circleColorOuter)
    
    switch loaderType {
    case .Infinite:
        path = UIBezierPath(arcCenter: arcCenter,
            radius: circleRadiusMiddle,
            startAngle: CIRCLE_START_ANGLE,
            endAngle: CIRCLE_END_ANGLE,
            clockwise: true)
    case .Progress:
        path = UIBezierPath(arcCenter: arcCenter,
            radius: circleRadiusMiddle,
            startAngle: 0,
            endAngle: CGFloat(M_PI) / 180 * 3.6 * 1,
            clockwise: true)
    }
    configureLayer(middleCircle, forView: view, withPath: path.CGPath, withBounds: viewBounds, withColor: config.circleColorMiddle)
    
    switch loaderType {
    case .Infinite:
        path = UIBezierPath(arcCenter: arcCenter,
            radius: circleRadiusInner,
            startAngle: CIRCLE_START_ANGLE,
            endAngle: CIRCLE_END_ANGLE,
            clockwise: true)
    case .Progress:
        path = UIBezierPath(arcCenter: arcCenter,
            radius: circleRadiusInner,
            startAngle: 0,
            endAngle: CGFloat(M_PI) / 180 * 3.6 * 1,
            clockwise: true)
    }
    configureLayer(innerCircle, forView: view, withPath: path.CGPath, withBounds: viewBounds, withColor: config.circleColorInner)
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
    outerAnimation.duration = config.circleRotationDurationOuter
    outerAnimation.repeatCount = CIRCLE_ROTATION_REPEAT_COUNT
    outerCircle.addAnimation(outerAnimation, forKey: "outerCircleRotation")
    
    let middleAnimation = outerAnimation.copy() as! CABasicAnimation
    middleAnimation.duration = config.circleRotationDurationMiddle
    middleCircle.addAnimation(middleAnimation, forKey: "middleCircleRotation")
    
    let innerAnimation = middleAnimation.copy() as! CABasicAnimation
    innerAnimation.duration = config.circleRotationDurationInner
    innerCircle.addAnimation(innerAnimation, forKey: "middleCircleRotation")
}

private func cleanupLoader(loader: Loader) {
    loader.backgroundView.removeFromSuperview()
}

private extension UIColor {
    
    static func gs_colorWithRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
}
