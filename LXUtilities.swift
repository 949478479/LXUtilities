//
//  LXUtilities.swift
//
//  Created by 从今以后 on 16/1/2.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import Foundation

struct Swifty<Base> {
	let base: Base
	init(_ base: Base) {
		self.base = base
	}
}

protocol SwiftyProtocol {
	associatedtype CompatibleType
	var lx: Swifty<CompatibleType> { get }
	static var lx: Swifty<CompatibleType>.Type { get }
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
