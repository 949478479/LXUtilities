//
//  Data+LXExtension.swift
//
//  Created by 从今以后 on 2017/11/23.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import Foundation

extension Data: SwiftyProtocol {}
extension Swifty where Base == Data {
    var hexString: String {
        return base.map { String(format: "%02.2hhx", $0) }.joined()
    }
}
