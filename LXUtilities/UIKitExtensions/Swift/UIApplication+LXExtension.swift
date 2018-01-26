//
//  UIApplication+LXExtension.swift
//  SLHTClient
//
//  Created by 冠霖环如 on 2017/12/27.
//  Copyright © 2017年 冠霖环如. All rights reserved.
//

import UIKit

extension Swifty where Base: UIApplication {
    
    /// 拨打电话。
    ///
    /// - Parameters:
    ///   - tel: 电话号码
    ///   - completion: 异步主线程回调，闭包参数 `success` 表示拨打成功或失败
    static func call(tel: String, completionHandler completion: ((_ success: Bool) -> Void)? = nil) {
        let url = URL(string: "tel://\(tel)")!
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: completion)
        } else {
            DispatchQueue.global(qos: .userInteractive).async {
                let success = UIApplication.shared.openURL(url)
                if let completion = completion {
                    DispatchQueue.main.async {
                        completion(success)
                    }
                }
            }
        }
    }
}
