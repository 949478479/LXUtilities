//
//  CGGeometry+LXExtension.swift
//
//  Created by 从今以后 on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import Foundation.NSValue
import CoreGraphics.CGGeometry

typealias NSValueType = NSValue

extension CGPoint {

    var NSValue: NSValueType {
        return NSValueType(cgPoint: self)
    }

    func adjustBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }

    mutating func adjustInPlace(dx: CGFloat, dy: CGFloat) {
        x += dx
        y += dy
    }
}

extension CGSize {

    var NSValue: NSValueType {
        return NSValueType(cgSize: self)
    }

    func adjustBy(dw: CGFloat, dh: CGFloat) -> CGSize {
        return CGSize(width: width + dw, height: height + dh)
    }

    mutating func adjustInPlace(dw: CGFloat, dh: CGFloat) {
        width  += dw
        height += dh
    }
}

extension CGRect {

    var NSValue: NSValueType {
        return NSValueType(cgRect: self)
    }

    func transformBy(_ t: CGAffineTransform) -> CGRect {
        return self.applying(t)
    }

    mutating func transformInPlace(_ t: CGAffineTransform) {
        self = self.applying(t)
    }
}
