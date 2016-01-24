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
        print(self.view.subviews.count)
        ARSLineProgress.showWithProgress(initialValue: progress, onView: view)
        launchTimer()
    }
    
}


// MARK: Helper Demo Methods

private var progress:CGFloat = 0.0

extension ViewController {
    
    private func launchTimer() {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.7 * Double(NSEC_PER_SEC)));
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            progress += CGFloat(arc4random_uniform(10))
            ARSLineProgress.updateWithProgress(progress)
            
            if progress >= 100 {
                progress = 0
                self.hideLoader()
                return
            }
            
            self.launchTimer()
        })
    }
    
    private func hideLoader() {
        print(self.view.subviews.count)
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(3) * NSEC_PER_SEC));
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            ARSLineProgress.hide()
        })
        
        dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(6) * NSEC_PER_SEC));
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            print(self.view.subviews.count)
        })
    }
    
}
