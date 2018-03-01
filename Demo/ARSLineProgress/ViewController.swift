//
//  ViewController.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 02.01.16.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//

import UIKit


final class ViewController: UIViewController {

    @IBAction func showInfiniteLoader(_ sender: AnyObject) {
        if ARSLineProgress.shown { return }
        
        ARSLineProgress.showWithPresentCompetionBlock("I am title") {
            print("Showed with completion block")
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
            
            ARSLineProgress.showSuccess()
//            ARSLineProgress.hideWithCompletionBlock({ () -> Void in
//                print("Hidden with completion block")
//            })
        })
    }
    
    // MARK: In case you want, you can use regular CGFloat value with showWithProgress(initialValue: 1.0) method.
    
    @IBAction func showProgressLoaderWithSuccess(_ sender: AnyObject) {
        if ARSLineProgress.shown { return }
        
        progressObject = Progress(totalUnitCount: 100)
        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
            print("Success completion block")
        })
        
        progressDemoHelper(success: true)
    }
    
    @IBAction func showProgressLoaderWithFail(_ sender: AnyObject) {
        if ARSLineProgress.shown { return }

        progressObject = Progress(totalUnitCount: 100)
        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
            print("This copmletion block is going to be overriden by cancel completion block in ars_launchTimer() method.")
        })
        
        progressDemoHelper(success: false)
    }
    
    
    @IBAction func showProgressWithoutAnimation(_ sender: AnyObject) {
        if ARSLineProgress.shown { return }

        ARSLineProgressConfiguration.showSuccessCheckmark = false
        
        progressObject = Progress(totalUnitCount: 100)
        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
            print("Success completion block")
            ARSLineProgressConfiguration.restoreDefaults()
        })
        
        progressDemoHelper(success: true)
    }
    
    @IBAction func didTapShowSuccessButton(_ sender: AnyObject) {
        ARSLineProgress.showSuccess("Success")
    }
    
    @IBAction func didTapShowFailButton(_ sender: AnyObject) {
        ARSLineProgress.showFail("Fail")
	}
	
	@IBAction func showFullBackgroundLoader(_ sender: AnyObject) {
		if ARSLineProgress.shown { return }
		
		ARSLineProgressConfiguration.backgroundViewStyle = .full
		ARSLineProgressConfiguration.backgroundViewColor = UIColor.white.cgColor
		ARSLineProgressConfiguration.backgroundViewDismissTransformScale = 1
		
		ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
			print("Showed with completion block")
		}
		
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: { () -> Void in
			ARSLineProgress.hideWithCompletionBlock({ () -> Void in
				print("Hidden with completion block")
				
				ARSLineProgressConfiguration.restoreDefaults()
			})
		})
	}
}


// MARK: Helper Demo Methods

private var progressObject: Progress?
private var isSuccess: Bool?

extension ViewController {
    
    fileprivate func progressDemoHelper(success: Bool) {
        isSuccess = success
        ars_launchTimer()
    }
    
    fileprivate func ars_launchTimer() {
        let dispatchTime = DispatchTime.now() + Double(Int64(0.7 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC);
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            progressObject!.completedUnitCount += Int64(arc4random_uniform(30))
            
            if isSuccess == false && progressObject?.fractionCompleted >= 0.7 {
                ARSLineProgress.cancelProgressWithFailAnimation(true, completionBlock: {
                    print("Hidden with completion block")
                })
                return
            } else {
                if progressObject?.fractionCompleted >= 1.0 { return }
            }
            
            self.ars_launchTimer()
        })
    }
    
}

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
	switch (lhs, rhs) {
	case let (l?, r?):	return l < r
	case (nil, _?):		return true
	default:			return false
	}
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
	switch (lhs, rhs) {
	case let (l?, r?):	return l >= r
	default:			return !(lhs < rhs)
	}
}
