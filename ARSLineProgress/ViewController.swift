//
//  ViewController.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 02.01.16.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBAction func showInfiniteLoader(sender: AnyObject) {
        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
            print("Showed with completion block")
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                print("Hidden with completion block")
            })
        })
    }
    
    // MARK: In case you want, you can use regular CGFloat value with showWithProgress(initialValue: 1.0) method.
    
    @IBAction func showProgressLoaderWithSuccess(sender: AnyObject) {
        progressObject = NSProgress(totalUnitCount: 100)
        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
            print("Success completion block")
        })
        
        progressDemoHelper(success: true)
    }
    
    @IBAction func showProgressLoaderWithFail(sender: AnyObject) {
        progressObject = NSProgress(totalUnitCount: 100)
        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
            print("This copmletion block is going to be overriden by cancel completion block in launchTimer() method.")
        })
        
        progressDemoHelper(success: false)
    }
    
    
    @IBAction func showProgressWithoutAnimation(sender: AnyObject) {
        ARSLineProgressConfiguration.showSuccessCheckmark = false
        
        progressObject = NSProgress(totalUnitCount: 100)
        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
            print("Success completion block")
        })
        
        progressDemoHelper(success: true)
    }
    
}


// MARK: Helper Demo Methods

private var progress: CGFloat = 0.0
private var progressObject: NSProgress?
private var isSuccess: Bool?

extension ViewController {
    
    private func progressDemoHelper(success success: Bool) {
        isSuccess = success
        launchTimer()
    }
    
    private func launchTimer() {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.7 * Double(NSEC_PER_SEC)));
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            progressObject!.completedUnitCount += Int64(arc4random_uniform(30))
            
            if isSuccess == false && progressObject?.fractionCompleted >= 0.7 {
                ARSLineProgress.cancelPorgressWithFailAnimation(true, completionBlock: {
                    print("Hidden with completion block")
                })
                return
            } else {
                if progressObject?.fractionCompleted >= 1.0 { return }
            }
            
            self.launchTimer()
        })
    }
    
}
