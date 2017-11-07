//
//  LXUtilities.swift
//
//  Created by 从今以后 on 16/1/2.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import UIKit

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

extension Swifty where Base: AnyObject {

    func synchronized(_ action: () -> Void) {
        objc_sync_enter(base)
        action()
        objc_sync_exit(base)
    }
}

// MARK: - 运算符重载

func + (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) + rhs
}

func + (lhs: CGFloat, rhs: Int) -> CGFloat {
    return rhs + lhs
}

func * (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) * rhs
}

func * (lhs: CGFloat, rhs: Int) -> CGFloat {
    return rhs * lhs
}

func / (lhs: Int, rhs: CGFloat) -> CGFloat {
    return CGFloat(lhs) / rhs
}

func / (lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs / CGFloat(rhs)
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

// MARK: - 数值扩展

extension Swifty where Base: BinaryFloatingPoint {
    var ceiled: Base {
        return ceil(base)
    }
}

extension CGFloat: SwiftyProtocol {}
extension Swifty where Base == CGFloat {
    var ceiled: Base {
        return ceil(base)
    }
}

extension Int: SwiftyProtocol {}
extension Swifty where Base == Int {
    var CGFloatValue: CGFloat {
        return CGFloat(base)
    }
}

extension Double: SwiftyProtocol {}
extension Swifty where Base == Double {
    var CGFloatValue: CGFloat {
        return CGFloat(base)
    }
}
