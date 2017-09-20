//
//  CGAffineTransform+LXExtension.swift
//
//  Created by 从今以后 on 16/1/10.
//  Copyright © 2016年 apple. All rights reserved.
//

import CoreGraphics.CGAffineTransform

extension CGAffineTransform {

    var NSValue: NSValueType {
        return NSValueType(cgAffineTransform: self)
    }

    func CGAffineTransformMakeScaleTranslate(_ sx: CGFloat, _ sy: CGFloat, _ tx: CGFloat, _ ty: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(a: sx, b: 0, c: 0, d: sy, tx: tx, ty: ty)
    }

    mutating func scaleInPlace(sx: CGFloat, sy: CGFloat) {
        self = self.scaledBy(x: sx, y: sy)
    }

    mutating func rotateInPlace(angle: CGFloat) {
        self = self.rotated(by: angle)
    }

    mutating func translateInPlace(tx: CGFloat, ty: CGFloat) {
        self = self.translatedBy(x: tx, y: ty)
    }
}
