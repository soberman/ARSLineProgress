//
//  ViewController2.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 17.01.16.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//

import UIKit

final class ViewController2: UIViewController {
    
    private var backgroundRect = UIView()
    private var outerCircle = CAShapeLayer()
    private var middleCircle = CAShapeLayer()
    private var innerCircle = CAShapeLayer()
    private var multiplier: CGFloat = 1.0
    private var progress: CGFloat = 0.0 {
        didSet {
//            if oldValue <= 100 { self.incrementMultiplier() }
        }
    }
    private var timer = NSTimer()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        createBackgroundRect()
        createCircles()
        animateCircles()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 10
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(4.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 10
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(6.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(7.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 10
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 10
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(4.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 10
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(6.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 3
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(7.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 10
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(8.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.progress += 10
        })
        
        
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("incrementMultiplier"), userInfo: nil, repeats: true)
    }
    
    func incrementMultiplier() {
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

// MARK: - Circle Creation

private extension ViewController2 {
    
    func createBackgroundRect() {
        let screenCenter = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
        backgroundRect.frame = CGRectMake(screenCenter.x - 62.5, screenCenter.y - 62.5, 125, 125)
        backgroundRect.backgroundColor = UIColor.whiteColor()
        backgroundRect.layer.cornerRadius = 20
        view.addSubview(backgroundRect)
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
    
}

// MARK: - Animation

private extension ViewController2 {
    
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
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.showFailmark()
        })
    }
    
    func showCheckmark() {
        let group = CGRectMake(CGRectGetMinX(backgroundRect.bounds), CGRectGetMinY(backgroundRect.bounds), CGRectGetWidth(backgroundRect.bounds), CGRectGetHeight(backgroundRect.bounds));
        let checkmark = UIBezierPath()
        checkmark.moveToPoint(CGPointMake(CGRectGetMidX(group) - 27, CGRectGetMidY(group)))
        checkmark.addLineToPoint(CGPointMake(CGRectGetMidX(group) - 2, CGRectGetMidY(group) + 25))
        checkmark.addLineToPoint(CGPointMake(CGRectGetMidX(group) + 33, CGRectGetMidY(group) - 30))
        checkmark.lineCapStyle = .Round
        
        let checkmarkShape = CAShapeLayer()
        checkmarkShape.path = checkmark.CGPath
        checkmarkShape.strokeColor = UIColor.gs_colorWithRGB(82.0, green: 124.0, blue: 194.0, alpha: 1.0).CGColor
        checkmarkShape.fillColor = UIColor.clearColor().CGColor
        checkmarkShape.lineWidth = 2.0
        checkmarkShape.lineCap = kCALineCapRound
        checkmarkShape.rasterizationScale = UIScreen.mainScreen().scale
        backgroundRect.layer.addSublayer(checkmarkShape)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.6
        animation.fillMode = kCAFillModeForwards
        checkmarkShape.addAnimation(animation, forKey: "")
    }
    
    func showFailmark() {
        let group = CGRectMake(CGRectGetMinX(backgroundRect.bounds), CGRectGetMinY(backgroundRect.bounds), CGRectGetWidth(backgroundRect.bounds), CGRectGetHeight(backgroundRect.bounds));
        let failmark = UIBezierPath()
        failmark.moveToPoint(CGPointMake(CGRectGetMinX(group) + 30, CGRectGetMinY(group) + 30))
        failmark.addLineToPoint(CGPointMake(CGRectGetMaxX(group) - 30, CGRectGetMaxY(group) - 30))
        failmark.closePath()
        failmark.moveToPoint(CGPointMake(CGRectGetMaxX(group) - 30, CGRectGetMinY(group) + 30))
        failmark.addLineToPoint(CGPointMake(CGRectGetMinX(group) + 30, CGRectGetMaxY(group) - 30))
        failmark.lineCapStyle = .Round
        
        let failmarkShape = CAShapeLayer()
        failmarkShape.path = failmark.CGPath
        failmarkShape.strokeColor = UIColor.gs_colorWithRGB(82.0, green: 124.0, blue: 194.0, alpha: 1.0).CGColor
        failmarkShape.fillColor = UIColor.clearColor().CGColor
        failmarkShape.lineWidth = 2.0
        failmarkShape.lineCap = kCALineCapRound
        failmarkShape.rasterizationScale = UIScreen.mainScreen().scale
        backgroundRect.layer.addSublayer(failmarkShape)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.6
        animation.fillMode = kCAFillModeForwards
        failmarkShape.addAnimation(animation, forKey: "")
    }
    
}
