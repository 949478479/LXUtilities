//
//  LXUtilities.swift
//
//  Created by 从今以后 on 16/1/2.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import UIKit

// MARK: - 运算符

infix operator ???: NilCoalescingPrecedence

/// 打印可选值时，当可选值为 nil 时返回指定文本。示例：
/// let a: Double? = nil
/// print(a ??? "n/a") // n/a
func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?:
        return "\(value)"
    case nil:
        return defaultValue()
    }
}

infix operator !?: NilCoalescingPrecedence

/// 当可选值为 nil 时，debug 模式下触发断言并提示指定文本，release 模式下返回默认值。示例：
/// Int("foo") !? (233, "Expected integer")
func !?<T>(wrapped: T?, nilDefault: @autoclosure () -> (value: T, text: String)) -> T {
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}

/// 检测一个可选链调用遇到 nil 而并没有完成调用的情况，debug 模式下将触发断言。示例：
/// var output: String? = nil
/// output?.write("something") !? "Wasn't expecting chained nil here"
func !?(wrapped: ()?, failureText: @autoclosure () -> String) {
    assert(wrapped != nil, failureText)
}

// MARK: - 全局函数

struct LX {

    static func printLog(_ log: @autoclosure () -> String = "",
                         file: String = #file,
                         line: Int = #line,
                         function: String = #function)
    {
        #if DEBUG
        print("\(function) at \((file as NSString).lastPathComponent)[\(line)]", log())
        #endif
    }

    static func value(from any: Any, forKey key: String) -> Any? {
        return Mirror(reflecting: any).children.first { $0.0 == key }?.value
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

    static func synchronized(_ any: Any, _ action: () -> Void) {
        objc_sync_enter(any)
        action()
        objc_sync_exit(any)
    }

}

// MARK: - 扩展包装

struct Swifty<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol SwiftyProtocol_class: class {
    associatedtype LXCompatibleType
    var lx: Swifty<LXCompatibleType> { get }
    static var lx: Swifty<LXCompatibleType>.Type { get }
}

extension SwiftyProtocol_class {
    var lx: Swifty<Self> {
        set {}
        get { return Swifty(self) }
    }
    static var lx: Swifty<Self>.Type {
        set {}
        get { return Swifty<Self>.self }
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

extension NSObject: SwiftyProtocol_class {}

// MARK: - 包装自定义结构体实现“写时拷贝”

/// var rect1 = CopyOnWriteBox(CGRect(x: 1, y: 2, width: 3, height: 4))
/// rect1.value.origin.x = 666
struct CopyOnWriteBox<T> {

	private var ref: Ref<T>

	init(_ value: T) {
		self.ref = Ref(value)
	}

	var value: T {
		get {
            return ref.value
        }
		set {
			if isKnownUniquelyReferenced(&ref) {
				ref.value = newValue
			} else {
				ref = Ref(newValue)
			}
		}
	}

	private class Ref<T> {
		var value: T
		init(_ value: T) {
			self.value = value
		}
	}

}
