//
//  Dispatch+LXExtension.swift
//  DistributionPlatform
//
//  Created by 冠霖环如 on 2017/9/30.
//  Copyright © 2017年 冠霖环如. All rights reserved.
//

import Foundation

extension Swifty where Base: DispatchQueue {

    func asyncAfter(_ delay: TimeInterval, execute: @escaping () -> Void) {
        base.asyncAfter(deadline: .now() + delay, execute: execute)
    }

    func asyncAfter(_ delay: TimeInterval, execute: DispatchWorkItem) {
        base.asyncAfter(deadline: .now() + delay, execute: execute)
    }
}
