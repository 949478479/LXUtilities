//
//  UIView+LXExtension.swift
//
//  Created by 从今以后 on 15/11/17.
//  Copyright © 2015年 从今以后. All rights reserved.
//

import UIKit

extension UIView {

    /// 根据类名同名 `xib` 文件实例化视图。
    static func instantiateFromNib() -> Self {
        return instantiateFromNibWithOwner(nil, options: nil)
    }

    /// 根据类名同名 `xib` 文件实例化视图。
    static func instantiateFromNibWithOwner(_ ownerOrNil: AnyObject?,
        options optionsOrNil: [AnyHashable: Any]?) -> Self {

        func _instantiateWithType<T>(_ type: T.Type,
            ownerOrNil: AnyObject?,
            optionsOrNil: [AnyHashable: Any]?) -> T {

            let views = UINib(nibName: String(describing: type), bundle: nil).instantiate(withOwner: nil, options: nil)
            for view in views where type(of: (view) as AnyObject) == type { return (view as! T) }

            fatalError("\(String(describing: type)).xib 文件中未找到对应实例.")
        }

        return _instantiateWithType(self, ownerOrNil: ownerOrNil, optionsOrNil: optionsOrNil)
    }
}
