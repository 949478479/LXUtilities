//
//  UITextField+LXExtension.swift
//
//  Created by 从今以后 on 2017/11/17.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UITextField {

    var placeholderColor: UIColor {
        set {
            base.setValue(newValue, forKeyPath: "placeholderLabel.textColor")
        }
        get {
            return base.value(forKeyPath: "placeholderLabel.textColor") as! UIColor
        }
    }
}
