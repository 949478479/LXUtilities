//
//  MBProgressHUD+LXExtension.swift
//
//  Created by 从今以后 on 2017/11/30.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import MBProgressHUD

extension Swifty where Base: MBProgressHUD {

    /// 创建 HUD 并添加到指定视图上，持续显示原生风格的活动指示器。
    ///
    /// - Parameter view: HUD 的父视图，默认为顶层窗口
    /// - Returns:        创建的 HUD 实例
    @discardableResult static func showIndicator(to view: UIView = UIWindow.lx.topWindow()) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.bezelView.style = .solidColor
        hud.bezelView.color = .clear
        return hud
    }

    /// 创建 HUD 并添加到指定视图上，短暂显示提示文字后自动移除。
    ///
    /// - Parameters:
    ///   - status: 提示文字
    ///   - view:   HUD 的父视图，默认为顶层窗口
    /// - Returns:  创建的 HUD 实例
    @discardableResult static func showStatus(_ status: String, to view: UIView = UIWindow.lx.topWindow()) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = status
        hud.hide(animated: true, afterDelay: 1)
        return hud
    }
}
