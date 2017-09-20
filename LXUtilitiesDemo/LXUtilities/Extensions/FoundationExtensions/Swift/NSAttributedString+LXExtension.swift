//
//  NSAttributedString+LXExtension.swift
//  ofo_demo
//
//  Created by 从今以后 on 2017/7/17.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import Foundation

extension Swifty where Base: NSAttributedString {

	var stringRange: NSRange {
		return NSRange(location: 0, length: base.string.count)
	}
}
