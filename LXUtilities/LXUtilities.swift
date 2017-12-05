//
//  LXUtilities.swift
//
//  Created by 从今以后 on 16/1/2.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import UIKit

struct lx {

    static func printLog(_ log: @autoclosure () -> String = "", file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
            print("\(function) at \((file as NSString).lastPathComponent)[\(line)]", log())
        #endif
    }

    static func value(from object: Any, forKey key: String) -> Any? {
        for case let (label?, value) in Mirror(reflecting: object).children.lazy where label == key {
            return value
        }
        return nil
    }

    static func value(from any: Any) -> Any? {
        let mirror = Mirror(reflecting: any)
        guard mirror.displayStyle == .optional else {
            return any
        }
        if let value = mirror.children.first?.value {
            return value
        }
        return nil
    }
}

extension Swifty where Base: AnyObject {

    func synchronized(_ action: () -> Void) {
        objc_sync_enter(base)
        action()
        objc_sync_exit(base)
    }
}

// MARK: - 扩展包装

final class Swifty<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol SwiftyProtocol {
    associatedtype LXCompatibleType
    var lx: Swifty<LXCompatibleType> { get }
    static var lx: Swifty<LXCompatibleType>.Type { get }
}

extension SwiftyProtocol {
    var lx: Swifty<Self> {
        return Swifty(self)
    }
    static var lx: Swifty<Self>.Type {
        return Swifty<Self>.self
    }
}

extension NSObject: SwiftyProtocol {}
