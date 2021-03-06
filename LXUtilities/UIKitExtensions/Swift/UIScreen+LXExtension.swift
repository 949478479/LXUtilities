//
//  UIScreen+LXExtension.swift
//
//  Created by 从今以后 on 2017/10/8.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UIScreen {

	static var size: CGSize {
		return Base.main.bounds.size
	}

	static var scale: CGFloat {
		return Base.main.scale
	}
}
