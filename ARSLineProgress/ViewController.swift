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
        ARSLineProgress.showWithProgress(0.0)
    }
    
}
