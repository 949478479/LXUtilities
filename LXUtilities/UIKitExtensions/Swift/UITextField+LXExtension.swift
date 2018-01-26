//
//  UITextField+LXExtension.swift
//  SLHTClient
//
//  Created by 冠霖环如 on 2017/11/17.
//  Copyright © 2017年 冠霖环如. All rights reserved.
//

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
