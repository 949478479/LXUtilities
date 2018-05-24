//
//  CATransaction+LXExtension.swift
//
//  Created by 从今以后 on 16/1/12.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import QuartzCore

extension Swifty where Base: CATransaction {

    /**
     开启事务，在事务中禁用隐式动画。

     - parameter actionsWithoutAnimation: 在闭包内修改图层属性不会触发隐式动画。
     */
    static func performWithoutAnimation(_ actionsWithoutAnimation: () -> ()) {
        Base.begin()
        Base.setDisableActions(true)
        actionsWithoutAnimation()
        Base.commit()
    }

    /**
     开启事务，并在其中添加隐式和显式的图层动画。

     - parameter duration:   隐式动画持续时间，若显式动画未设置动画时间，则会使用该值。
     - parameter animations: 在闭包中修改图层属性或添加图层动画。
     - parameter completion: 此闭包会在事务中的全部动画均完成时调用。
     */
    static func animateWithDuration(
        _ duration: CFTimeInterval,
        animations: () -> (),
        completion: (() -> ())? = nil)
    {
        Base.begin()
        Base.setAnimationDuration(duration)
        Base.setCompletionBlock(completion)
        animations()
        Base.commit()
    }
}
