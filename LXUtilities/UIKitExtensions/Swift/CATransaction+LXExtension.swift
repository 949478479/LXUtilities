//
//  CATransaction+LXExtension.swift
//
//  Created by 从今以后 on 16/1/12.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import QuartzCore

extension Swifty where Base: CATransaction {

    /**
     禁用隐式动画。

     - parameter actionsWithoutAnimation: 在闭包内修改图层属性不会触发隐式动画
     */
    static func performWithoutAnimation(_ actionsWithoutAnimation: () -> ()) {
        Base.begin()
        Base.setDisableActions(true)
        actionsWithoutAnimation()
        Base.commit()
    }

    /**
     定制隐式动画。

     - parameter duration:   隐式动画持续时间。
     - parameter animations: 在此闭包内修改图层属性。
     - parameter completion: 隐式动画完成时调用此闭包。
     */
    static func animateWithDuration(_ duration: CFTimeInterval, animations: () -> (),
        completion: (() -> ())? = nil) {
        Base.begin()
        Base.setAnimationDuration(duration)
        Base.setCompletionBlock(completion)
        animations();
        Base.commit()
    }
}
