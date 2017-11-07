//
//  CAAnimation+LXExtension.swift
//
//  Created by 从今以后 on 16/1/10.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import QuartzCore

@nonobjc extension CAMediaTimingFunction {
	static let linear = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
	static let easeIn = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
	static let easeOut = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
	static let easeInEaseOut = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
}
