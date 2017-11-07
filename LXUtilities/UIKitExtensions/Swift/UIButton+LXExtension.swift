//
//  UIButton+LXExtension.swift
//  sosomk
//
//  Created by 冠霖环如 on 2017/10/20.
//  Copyright © 2017年 冠霖环如. All rights reserved.
//

import UIKit

extension Swifty where Base: UIButton {

    var normalTitle: String? {
        set {
            base.setTitle(newValue, for: .normal)
        }
        get {
            return base.title(for: .normal)
        }
    }
}
