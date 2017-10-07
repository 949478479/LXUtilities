//
//  UIDevice+LXExtension.swift
//
//  Created by 从今以后 on 2017/10/7.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UIDevice {
	
	static var isPhoneX: Bool {
		return UIScreen.main.bounds.size == CGSize(width: 375, height: 812)
	}
}
