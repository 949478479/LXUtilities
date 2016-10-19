//
//  LXUtilities.swift
//
//  Created by 从今以后 on 16/1/2.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import Foundation

func printLog(_ items: Any, file: String = #file, line: Int = #line, function: String = #function) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)] \(function)\n", items, separator: "")
    #endif
}

func value(from object: Any, forKey key: String) -> Any? {
    for case let (label?, value) in Mirror(reflecting: object).children.lazy {
        if label == key {
            return value
        }
    }
    return nil
}
