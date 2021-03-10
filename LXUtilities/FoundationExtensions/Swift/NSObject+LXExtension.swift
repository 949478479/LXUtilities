//
//  NSObject+LXExtension.swift
//  这到底是什么鬼
//
//  Created by 不知什么人 on 2021/3/10.
//  Copyright © 2021 XinMo. All rights reserved.
//

private class Key {}

private var Map = [Int: [String: Key]]()

extension Swifty where Base: NSObject {

    private func address(of obj: AnyObject) -> Int {
        unsafeBitCast(obj, to: Int.self)
    }

    private func associatedObjectKey(forKey key: String) -> UnsafeMutableRawPointer {
        let token = Map[address(of: self.base), default: [:]][key, default: Key()]
        return Unmanaged.passUnretained(token).toOpaque()
    }

    func setAssociatedObject(_ obj: Any?, forKey key: String) {
        objc_setAssociatedObject(self.base, associatedObjectKey(forKey: key), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func getAssociatedObject<T>(forKey key: String) -> T? {
        objc_getAssociatedObject(self.base, associatedObjectKey(forKey: key)) as? T
    }
}
