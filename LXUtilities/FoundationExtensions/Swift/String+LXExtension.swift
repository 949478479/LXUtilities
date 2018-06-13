//
//  String+LXExtension.swift
//
//  Created by 从今以后 on 2017/10/12.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import Foundation

extension String: SwiftyProtocol {}

extension Swifty where Base == String {
    
    var url: URL? {
        return URL(string: base)
    }
}
