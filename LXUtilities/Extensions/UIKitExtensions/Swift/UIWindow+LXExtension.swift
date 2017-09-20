//
//  UIWindow+LXExtension.swift
//  ofo_demo
//
//  Created by 从今以后 on 2017/7/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UIWindow {

	static var key: UIWindow {
		if let window = UIWindow.value(forKey: "keyWindow") as? UIWindow {
			return window
		} else if let window = UIApplication.shared.delegate?.window, let _window = window {
			return _window
		}
		fatalError("window 不存在.")
	}
}
