//
//  ARSInfiniteLoader.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 09/10/2016.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//
//  Website: http://arsenkin.com
//

import UIKit

final class ARSInfiniteLoader: ARSLoader {
	
	@objc var emptyView = UIView()
	@objc var backgroundView: UIVisualEffectView
	@objc var outerCircle = CAShapeLayer()
	@objc var middleCircle = CAShapeLayer()
	@objc var innerCircle = CAShapeLayer()
	@objc weak var targetView: UIView?
	
	init() {
		backgroundView = ARSBlurredBackgroundRect().view
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(ARSInfiniteLoader.orientationChanged(_:)),
		                                       name: NSNotification.Name.UIDeviceOrientationDidChange,
		                                       object: nil)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self,
		                                          name: NSNotification.Name.UIDeviceOrientationDidChange,
		                                          object: nil)
	}
	
	@objc func orientationChanged(_ notification: Notification) {
		ars_dispatchOnMainQueue {
			if let loader = ars_currentLoader {
				if let targetView = loader.targetView {
					ars_createdFrameForBackgroundView(loader.backgroundView, onView: targetView)
				} else {
					ars_createdFrameForBackgroundView(loader.backgroundView, onView: nil)
				}
			}
		}
	}
	
}

extension ARSInfiniteLoader {
	
	func ars_showOnView(_ view: UIView?, completionBlock: (() -> Void)?) {
		if ars_createdFrameForBackgroundView(backgroundView, onView: view) == false { return }
		
		targetView = view
		
		ars_createCircles(outerCircle,
		                  middleCircle: middleCircle,
		                  innerCircle: innerCircle,
		                  onView: backgroundView.contentView,
		                  loaderType: .infinite)
		ars_animateCircles(outerCircle, middleCircle: middleCircle, innerCircle: innerCircle)
		ars_presentLoader(self, onView: view, completionBlock: completionBlock)
	}
	
}

