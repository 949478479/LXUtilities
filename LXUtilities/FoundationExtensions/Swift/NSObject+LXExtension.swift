//
//  NSObject+LXExtension.swift
//  这到底是什么鬼
//
//  Created by 不知什么人 on 2021/3/10.
//  Copyright © 2021 XinMo. All rights reserved.
//

import Foundation

private class Key {}

private var Map = [Int: [String: Key]]()

extension Swifty where Base: NSObject {

    func setAssociatedObject(_ obj: Any?, forKey key: String) {
        objc_setAssociatedObject(base, associatedObjectKey(forKey: key), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        if obj == nil {
            removeAssociatedObjectKey(forKey: key)
        }
    }

    func getAssociatedObject(forKey key: String) -> Any? {
        objc_getAssociatedObject(base, associatedObjectKey(forKey: key))
    }

    func address(of obj: AnyObject) -> Int {
        unsafeBitCast(obj, to: Int.self)
    }

    private func associatedObjectKey(forKey key: String) -> UnsafeMutableRawPointer {
        var map = Map[address(of: base)] ?? [:]
        let associatedKey = map[key] ?? {
            let k = Key()
            map[key] = k
            Map[address(of: base)] = map
            return k
        }()
        return Unmanaged.passUnretained(associatedKey).toOpaque()
    }

    private func removeAssociatedObjectKey(forKey key: String) {
        if var map = Map[address(of: base)] {
            map[key] = nil
            Map[address(of: base)] = map.isEmpty ? nil : map
        }
    }
}
