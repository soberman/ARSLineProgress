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
	@objc var backgroundBlurView: UIVisualEffectView
	@objc var backgroundSimpleView: UIView
	@objc var backgroundFullView: UIView
	@objc var backgroundView: UIView {
		switch ars_config.backgroundViewStyle {
		case .blur:
			return backgroundBlurView
		case .simple:
			return backgroundSimpleView
		case .full:
			return backgroundFullView
		}
	}
	@objc var outerCircle = CAShapeLayer()
	@objc var middleCircle = CAShapeLayer()
	@objc var innerCircle = CAShapeLayer()
	@objc weak var targetView: UIView?
	
	init() {
		backgroundBlurView = ARSBlurredBackgroundRect().view
		backgroundSimpleView = ARSSimpleBackgroundRect().view
		backgroundFullView = ARSFullBackgroundRect().view
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(ARSInfiniteLoader.orientationChanged(_:)),
		                                       name: UIDevice.orientationDidChangeNotification,
		                                       object: nil)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self,
		                                          name: UIDevice.orientationDidChangeNotification,
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
		                  onView: ((backgroundView as? UIVisualEffectView)?.contentView) ?? backgroundView,
		                  loaderType: .infinite)
		ars_animateCircles(outerCircle, middleCircle: middleCircle, innerCircle: innerCircle)
		ars_presentLoader(self, onView: view, completionBlock: completionBlock)
	}
	
}

