//
//  UIScreen+LXExtension.swift
//  WuLianWu
//
//  Created by 从今以后 on 2017/10/8.
//  Copyright © 2017年 冠霖环如. All rights reserved.
//

import UIKit

extension Swifty where Base: UIScreen {

	var size: CGSize {
		return Base.main.bounds.size
	}

	var scale: CGFloat {
		return Base.main.scale
	}
}
