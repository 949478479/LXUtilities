//
//  String+LXExtension.swift
//  WuLianWu
//
//  Created by 冠霖环如 on 2017/10/12.
//  Copyright © 2017年 冠霖环如. All rights reserved.
//

extension String: SwiftyProtocol {}

extension Swifty where Base == String {
    
    var url: URL? {
        return URL(string: base)
    }
}
