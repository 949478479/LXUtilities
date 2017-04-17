//
//  LXUtilities.swift
//
//  Created by 从今以后 on 16/1/2.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import Foundation

func printLog(_ log: String, file: String = #file, line: Int = #line, function: String = #function) {
    #if DEBUG
        print("\(function) at \((file as NSString).lastPathComponent)[\(line)]", log)
    #endif
}

func value(from object: Any, forKey key: String) -> Any? {
    for case let (label?, value) in Mirror(reflecting: object).children.lazy where label == key {
        return value
    }
    return nil
}

func synchronized(_ obj: Any, _ closure: () -> Void) {
    objc_sync_enter(obj)
    closure()
    objc_sync_exit(obj)
}
