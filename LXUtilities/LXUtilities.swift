//
//  LXUtilities.swift
//
//  Created by 从今以后 on 16/1/2.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import UIKit

func printLog(_ log: @autoclosure () -> String = "", file: String = #file, line: Int = #line, function: String = #function) {
	#if DEBUG
	print("\(function) at \((file as NSString).lastPathComponent)[\(line)]", log())
	#endif
}

func value(from object: Any, forKey key: String) -> Any? {
	for case let (label?, value) in Mirror(reflecting: object).children.lazy where label == key {
		return value
	}
	return nil
}

func value(from any: Any) -> Any? {
	let mirror = Mirror(reflecting: any)
	guard mirror.displayStyle == .optional else {
		return any
	}
	if let value = mirror.children.first?.value {
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
