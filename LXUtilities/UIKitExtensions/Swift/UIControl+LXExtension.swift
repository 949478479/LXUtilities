//
//  UIButton+LXExtension.swift
//  sosomk
//
//  Created by 冠霖环如 on 2017/10/20.
//  Copyright © 2017年 冠霖环如. All rights reserved.
//

import UIKit

extension Swifty where Base: UIControl {

    typealias ActionToken = String

    func addAction(for controlEvents: UIControl.Event, action: @escaping (UIControl, UIControl.Event) -> Void) -> ActionToken {
        let target = ActionTarget(action: action)
        let token = "\(base.lx.address(of: target))"
        base.lx.setAssociatedObject(target, forKey: token)
        base.addTarget(target, action: #selector(ActionTarget.action(sender:event:)), for: controlEvents)
        return token
    }

    func removeAction(withToken token: ActionToken, for controlEvents: UIControl.Event) {
        if let target = base.lx.getAssociatedObject(forKey: token) {
            base.removeTarget(target, action: #selector(ActionTarget.action(sender:event:)), for: controlEvents)
            base.lx.setAssociatedObject(nil, forKey: token)
        }
    }

    private class ActionTarget {

        let action: (UIControl, UIControl.Event) -> Void

        init(action: @escaping (UIControl, UIControl.Event) -> Void) {
            self.action = action
        }

        @objc func action(sender: UIControl, event: UIControl.Event) {
            action(sender, event)
        }
    }
}
