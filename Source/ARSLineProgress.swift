//
//  ARSLineProgress.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 24.01.16.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//
//  Website: http://arsenkin.com
//

import UIKit

public final class ARSLineProgress: NSObject {
    
    public static var shown: Bool { return ars_currentLoader != nil ? true : false }
    public static var statusShown: Bool { return ars_currentStatus != nil ? true : false }
    
    
    // MARK: Show Statuses
    
    
    /** 
        Will interrupt the current .Infinite loader progress and show success animation instead.
    */
    public static func showSuccess() {
        if !statusShown { ARSStatus.show(.success) }
    }
    
    /**
        Will interrupt the current .Infinite loader progress and show fail animation instead.
    */
    public static func showFail() {
        if !statusShown { ARSStatus.show(.fail) }
    }
    
    
    // MARK: Show Infinite Loader
    
    
    public static func show() {
        if !shown { ARSInfiniteLoader().showOnView(nil, completionBlock: nil) }
    }
    
    public static func showWithPresentCompetionBlock(_ block: @escaping () -> Void) {
        if !shown { ARSInfiniteLoader().showOnView(nil, completionBlock: block) }
    }
    
    public static func showOnView(_ view: UIView) {
        if !shown { ARSInfiniteLoader().showOnView(view, completionBlock: nil) }
    }
    
    public static func showOnView(_ view: UIView, completionBlock: @escaping () -> Void) {
        if !shown { ARSInfiniteLoader().showOnView(view, completionBlock: completionBlock) }
    }
    
    
    // MARK: Show Progress Loader
    
    
    /**
		Note: initialValue should be from 0 to 100
    */
    public static func showWithProgress(initialValue value: CGFloat) {
        if !shown { ARSProgressLoader().showWithValue(value, onView: nil, progress: nil, completionBlock: nil) }
    }
    
    /**
        Note: initialValue should be from 0 to 100
     */
    public static func showWithProgress(initialValue value: CGFloat, onView: UIView) {
        if !shown { ARSProgressLoader().showWithValue(value, onView: onView, progress: nil, completionBlock: nil) }
    }
    
    /**
        Note: initialValue should be from 0 to 100
     */
    public static func showWithProgress(initialValue value: CGFloat, completionBlock: (() -> Void)?) {
        if !shown { ARSProgressLoader().showWithValue(value, onView: nil, progress: nil, completionBlock: completionBlock) }
    }
    
    /**
        Note: initialValue should be from 0 to 100
     */
    public static func showWithProgress(initialValue value: CGFloat, onView: UIView, completionBlock: (() -> Void)?) {
        if !shown { ARSProgressLoader().showWithValue(value, onView: onView, progress: nil, completionBlock: completionBlock) }
    }
    
    public static func showWithProgressObject(_ progress: Progress) {
        if !shown { ARSProgressLoader().showWithValue(0.0, onView: nil, progress: progress, completionBlock: nil) }
    }
    
    public static func showWithProgressObject(_ progress: Progress, completionBlock: (() -> Void)?) {
        if !shown { ARSProgressLoader().showWithValue(0.0, onView: nil, progress: progress, completionBlock: completionBlock) }
    }
    
    public static func showWithProgressObject(_ progress: Progress, onView: UIView) {
        if !shown { ARSProgressLoader().showWithValue(0.0, onView: onView, progress: progress, completionBlock: nil) }
    }
    
    public static func showWithProgressObject(_ progress: Progress, onView: UIView, completionBlock: (() -> Void)?) {
        if !shown { ARSProgressLoader().showWithValue(0.0, onView: onView, progress: progress, completionBlock: completionBlock) }
    }
    
    
    // MARK: Update Progress Loader
    
    
    public static func updateWithProgress(_ value: CGFloat) {
        ARSProgressLoader.weakSelf?.progressValue = value
    }
    
    public static func cancelPorgressWithFailAnimation(_ showFail: Bool) {
        ARSProgressLoader.weakSelf?.cancelWithFailAnimation(showFail, completionBlock: nil)
    }
    
    public static func cancelPorgressWithFailAnimation(_ showFail: Bool, completionBlock: (() -> Void)?) {
        ARSProgressLoader.weakSelf?.cancelWithFailAnimation(showFail, completionBlock: completionBlock)
    }
    
    
    // MARK: Hide Loader
    
	
    public static func hide() {
        ars_hideLoader(ars_currentLoader, withCompletionBlock: nil)
    }
    
    /// <code>completionBlock</code> is going to be called on the main queue
    public static func hideWithCompletionBlock(_ block: @escaping () -> Void) {
        ars_hideLoader(ars_currentLoader, withCompletionBlock: block)
    }
    
}
