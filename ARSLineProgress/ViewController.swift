//
//  ViewController.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 02.01.16.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//

import UIKit
import GreatStuff

class ViewController: UIViewController {

    private var backgroundRect = UIView()
    private var outerCircle = CAShapeLayer()
    private var middleCircle = CAShapeLayer()
    private var innerCircle = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBackgroundRect()
        createCircles()
        animateCircles()
    }

}

// MARK: - Circle Creation

private extension ViewController {
    
    func createBackgroundRect() {
        let screenCenter = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
        backgroundRect.frame = CGRectMake(screenCenter.x - 100, screenCenter.y - 50, 200, 100)
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
        let path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 40.0, startAngle: -CGFloat(M_PI_2), endAngle: 0, clockwise: true)
        outerCircle.path = path.CGPath
        outerCircle.frame = backgroundRect.bounds
        outerCircle.lineWidth = 2.0
        outerCircle.strokeColor = UIColor.gs_colorWithRGB(130.0, green: 149.0, blue: 173.0, alpha: 1.0).CGColor
        outerCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(outerCircle)
    }
    
    func createMiddleCircle() {
        let path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 30.0, startAngle: -CGFloat(M_PI_2), endAngle: 0, clockwise: true)
        middleCircle.path = path.CGPath
        middleCircle.frame = backgroundRect.bounds
        middleCircle.lineWidth = 2.0
        middleCircle.strokeColor = UIColor.gs_colorWithRGB(82.0, green: 124.0, blue: 194.0, alpha: 1.0).CGColor
        middleCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(middleCircle)
    }
    
    func createInnerCircle() {
        let path = UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(backgroundRect.bounds), CGRectGetMidY(backgroundRect.bounds)), radius: 20.0, startAngle: -CGFloat(M_PI_2), endAngle: 0, clockwise: true)
        innerCircle.path = path.CGPath
        innerCircle.frame = backgroundRect.bounds
        innerCircle.lineWidth = 2.0
        innerCircle.strokeColor = UIColor.gs_colorWithRGB(60.0, green: 132.0, blue: 196.0, alpha: 1.0).CGColor
        innerCircle.fillColor = UIColor.clearColor().CGColor
        backgroundRect.layer.addSublayer(innerCircle)
    }
    
}

// MARK: - Animation

private extension ViewController {
    
    func animateCircles() {
        let outerAnimation = CABasicAnimation(keyPath: "transform.rotation")
        outerAnimation.fromValue = 0.0
        outerAnimation.toValue = 2 * CGFloat(M_PI)
        outerAnimation.duration = 2.0
        outerAnimation.repeatCount = 100
        outerCircle.addAnimation(outerAnimation, forKey: "outerCircleRotation")
        
        let middleAnimation = CABasicAnimation(keyPath: "transform.rotation")
        middleAnimation.fromValue = 0.0
        middleAnimation.toValue = 2 * CGFloat(M_PI)
        middleAnimation.duration = 1.0
        middleAnimation.repeatCount = 100
        middleCircle.addAnimation(middleAnimation, forKey: "middleCircleRotation")
        
        let innerAnimation = CABasicAnimation(keyPath: "transform.rotation")
        innerAnimation.fromValue = 0.0
        innerAnimation.toValue = 2 * CGFloat(M_PI)
        innerAnimation.duration = 0.5
        innerAnimation.repeatCount = 100
        innerCircle.addAnimation(innerAnimation, forKey: "middleCircleRotation")
    }
    
}
