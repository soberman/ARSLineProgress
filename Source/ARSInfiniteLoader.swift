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
    @objc var lbTitle: UILabel = UILabel()
    @objc var title: NSString?
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
        title = ""
		backgroundBlurView = ARSBlurredBackgroundRect().view
		backgroundSimpleView = ARSSimpleBackgroundRect().view
		backgroundFullView = ARSFullBackgroundRect().view
        
        lbTitle.textColor = ARS_TITLE_COLOR
        lbTitle.font = UIFont.systemFont(ofSize: ARS_TITLE_SIZE)
        
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
                    ars_createdFrameForBackgroundView(loader.backgroundView, title:loader.title, onView: targetView)
				} else {
                    ars_createdFrameForBackgroundView(loader.backgroundView, title:loader.title, onView: nil)
				}
			}
		}
	}
	
}

extension ARSInfiniteLoader {
	
    func ars_showOnView(_ view: UIView?, title: NSString?, completionBlock: (() -> Void)?) {
        self.title = title
        
		if ars_createdFrameForBackgroundView(backgroundView, title:self.title, onView: view) == false { return }
        
        if(title != nil && title!.length > 0){
            lbTitle.text = self.title! as String;
            lbTitle.sizeToFit();
            let parentView = ((backgroundView as? UIVisualEffectView)?.contentView) ?? backgroundView;
            parentView.addSubview(lbTitle);
            
            lbTitle.center = CGPoint(x:parentView.center.x,
                                     y:parentView.frame.origin.y + backgroundView.frame.size.height - ARS_TITLE_MARGIN - lbTitle.frame.size.height);
        }
        
        
		targetView = view
		
		ars_createCircles(outerCircle,
		                  middleCircle: middleCircle,
		                  innerCircle: innerCircle,
                          title: title,
		                  onView: ((backgroundView as? UIVisualEffectView)?.contentView) ?? backgroundView,
		                  loaderType: .infinite)
		ars_animateCircles(outerCircle, middleCircle: middleCircle, innerCircle: innerCircle)
		ars_presentLoader(self, onView: view, completionBlock: completionBlock)
	}
	
}

