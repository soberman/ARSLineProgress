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
        ARSLineProgress.show()
    }
    
    @IBAction func showProgressLoader(sender: AnyObject) {
        progressObject = NSProgress(totalUnitCount: 100)
        ARSLineProgress.showWithProgressObject(progressObject!)
        launchTimer()
    }
    
}


// MARK: Helper Demo Methods

private var progress: CGFloat = 0.0
private var progressObject: NSProgress?

extension ViewController {
    
    private func launchTimer() {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.7 * Double(NSEC_PER_SEC)));
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            progressObject!.completedUnitCount += Int64(arc4random_uniform(10))
            
            if progressObject?.fractionCompleted == 1.0 {
                self.hideLoader()
                return
            }
            
            self.launchTimer()
        })
    }
    
    private func hideLoader() {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(3) * NSEC_PER_SEC));
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            ARSLineProgress.hide()
        })
    }
    
}
