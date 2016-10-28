//
//  ARSLinePorgressProtocols.swift
//  ARSLineProgress
//
//  Created by Yaroslav Arsenkin on 09/10/2016.
//  Copyright © 2016 Iaroslav Arsenkin. All rights reserved.
//
//  Website: http://arsenkin.com
//

import UIKit

@objc protocol ARSLoader {
	var emptyView: UIView { get }
	var backgroundView: UIView { get }
	@objc optional var outerCircle: CAShapeLayer { get set }
	@objc optional var middleCircle: CAShapeLayer { get set }
	@objc optional var innerCircle: CAShapeLayer { get set }
	@objc optional weak var targetView: UIView? { get set }
}
