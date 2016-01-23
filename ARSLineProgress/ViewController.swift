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
        ARSLineProgress.showWithProgress(progress)
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
            self.launchTimer()
            
            if progress >= 100 {
                progress = 0
                self.hideLoader()
                return
            }
        })
    }
    
    private func hideLoader() {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(3) * NSEC_PER_SEC));
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            ARSLineProgress.hide()
        })
    }
    
}
