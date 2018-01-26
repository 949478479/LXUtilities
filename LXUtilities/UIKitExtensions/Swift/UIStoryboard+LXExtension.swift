//
//  UIStoryboard+LXExtension.swift
//
//  Created by 从今以后 on 2017/10/11.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UIStoryboard {

    /// 实例化指定故事版中的初始控制器.
    static func instantiateInitialViewController<T: UIViewController>(withStoryboardName name: String) -> T {
        return Base(name: name, bundle: nil).instantiateInitialViewController() as! T
    }

    /// 以类名作为标识符实例化指定故事版中的初始控制器.
    static func instantiateViewController<T: UIViewController>(withStoryboardName name: String, for type: T.Type) -> T {
        return Base(name: name, bundle: nil).instantiateViewController(withIdentifier: String(describing: type)) as! T
    }

    /// 实例化故事版中的初始控制器.
    func instantiateInitialViewController<T: UIViewController>() -> T {
        return base.instantiateInitialViewController() as! T
    }

    /// 以类名作为标识符实例化视图控制器.
    func instantiateViewController<T: UIViewController>(for type: T.Type) -> T {
        return base.instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
