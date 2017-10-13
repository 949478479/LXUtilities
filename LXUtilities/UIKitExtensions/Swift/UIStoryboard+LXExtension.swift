//
//  UIStoryboard+LXExtension.swift
//  WuLianWu
//
//  Created by 冠霖环如 on 2017/10/11.
//  Copyright © 2017年 冠霖环如. All rights reserved.
//

import UIKit

extension Swifty where Base: UIStoryboard {

    /// 以类名作为标识符实例化视图控制器.
    func instantiateViewController<T: UIViewController>(for type: T.Type) -> T {
        return base.instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
