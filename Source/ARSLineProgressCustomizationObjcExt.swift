//
//  ARSLineProgressCustomizationObjcExt.swift
//  ARSLineProgress
//
//  Created by Johnnie on 28/02/18.
//  Copyright © 2018 Iaroslav Arsenkin. All rights reserved.
//

import UIKit

extension ARSLineProgressConfiguration {
    @objc static func ars_setShowSuccessCheckmark(show : Bool){
        showSuccessCheckmark = show;
    }
    
    // MARK: background view
    @objc static func ars_setBackgroundViewDismissTransformScale(scale : CGFloat){
        backgroundViewDismissTransformScale = scale;
    }
    
    @objc static func ars_setBackgroundViewColor(color : CGColor){
        backgroundViewColor = color;
    }
    
    
    /// setBackgroundViewStyle
    ///
    /// - Parameter style: 0:blur, 1:simple, 2:full, default:blur
    @objc static func ars_setBackgroundViewStyle(style : NSInteger){
        switch style {
            
        case 0:
            backgroundViewStyle = .blur;
            break;
            
        case 1:
            backgroundViewStyle = .simple;
            break;
            
        case 2:
            backgroundViewStyle = .full;
            break;
            
            
        default:
            backgroundViewStyle = .blur;
            break;
        }
    }
    
    @objc static func ars_setBackgroundViewCornerRadius(radius : CGFloat){
        backgroundViewCornerRadius = radius;
    }
    
    @objc static func ars_setBackgroundViewPresentAnimationDuration(duration : CFTimeInterval){
        backgroundViewPresentAnimationDuration = duration;
    }
    
    @objc static func ars_setBackgroundViewDismissAnimationDuration(duration : CFTimeInterval){
        backgroundViewDismissAnimationDuration = duration;
    }
    
    @objc static func ars_setBlurStyle(style : UIBlurEffectStyle){
        blurStyle = style;
    }
    
    // MARK: circles
    @objc static func ars_setcircleColorOuter(color : CGColor){
        circleColorOuter = color;
    }
    
    @objc static func ars_setcircleColorMiddle(color : CGColor){
        circleColorMiddle = color;
    }
    
    @objc static func ars_setCircleColorInner(color : CGColor){
        circleColorInner = color;
    }
    
    @objc static func ars_setCircleRotationDurationOuter(duration : CFTimeInterval){
        circleRotationDurationOuter = duration;
    }
    
    @objc static func ars_setCircleRotationDurationMiddle(duration : CFTimeInterval){
        circleRotationDurationMiddle = duration;
    }
    
    @objc static func ars_setCircleRotationDurationInner(duration : CFTimeInterval){
        circleRotationDurationInner = duration;
    }

    
    // MARK: check mark
    @objc static func ars_setCheckmarkAnimationDrawDuration(duration : CFTimeInterval){
        checkmarkAnimationDrawDuration = duration;
    }
    
    @objc static func ars_setCheckmarkLineWidth(width : CGFloat){
        checkmarkLineWidth = width;
    }
    
    @objc static func ars_setCheckmarkColor(color : CGColor){
        checkmarkColor = color;
    }
    
    // MARK: success circle
    @objc static func ars_setSuccessCircleAnimationDrawDuration(duration : CFTimeInterval){
        successCircleAnimationDrawDuration = duration;
    }
    
    @objc static func ars_setSuccessCircleLineWidth(width : CGFloat){
        successCircleLineWidth = width;
    }
    
    @objc static func ars_setSuccessCircleColor(color : CGColor){
        successCircleColor = color;
    }
    
    // MARK: fail cross
    @objc static func ars_setFailCrossAnimationDrawDuration(duration : CFTimeInterval){
        failCrossAnimationDrawDuration = duration;
    }
    
    @objc static func ars_setFailCrossLineWidth(width : CGFloat){
        failCrossLineWidth = width;
    }
    
    @objc static func ars_setFailCrossColor(color : CGColor){
        failCrossColor = color;
    }
    
    // MARK: fail circel
    @objc static func ars_setFailCircleAnimationDrawDuration(duration : CFTimeInterval){
        failCircleAnimationDrawDuration = duration;
    }
    
    @objc static func ars_setFailCircleLineWidth(width : CGFloat){
        failCircleLineWidth = width;
    }
    
    @objc static func ars_setFailCircleColor(color : CGColor){
        failCircleColor = color;
    }
}
