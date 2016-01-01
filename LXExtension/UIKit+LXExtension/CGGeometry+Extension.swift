//
//  CGGeometry+Extension.swift
//
//  Created by 从今以后 on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import CoreGraphics

extension CGPoint {

    func adjustBy(dx dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }

    mutating func adjustInPlace(dx dx: CGFloat, dy: CGFloat) {
        x += dx
        y += dy
    }
}

extension CGSize {

    func adjustBy(dw dw: CGFloat, dh: CGFloat) -> CGSize {
        return CGSize(width: width + dw, height: height + dh)
    }

    mutating func adjustInPlace(dw dw: CGFloat, dh: CGFloat) {
        width  += dw
        height += dh
    }
}

extension CGRect {

    func transformBy(t: CGAffineTransform) -> CGRect {
        return CGRectApplyAffineTransform(self, t)
    }

    mutating func transformInPlace(t: CGAffineTransform) {
        self = CGRectApplyAffineTransform(self, t)
    }
}

extension CGAffineTransform {

    func CGAffineTransformMakeScaleTranslate(sx: CGFloat, _ sy: CGFloat, _ tx: CGFloat, _ ty: CGFloat) -> CGAffineTransform {
        return CGAffineTransformMake(sx, 0, 0, sy, tx, ty)
    }

    mutating func scaleInPlace(sx sx: CGFloat, sy: CGFloat) {
        self = CGAffineTransformScale(self, sx, sy)
    }

    mutating func rotateInPlace(angle angle: CGFloat) {
        self = CGAffineTransformRotate(self, angle)
    }

    mutating func translateInPlace(tx tx: CGFloat, ty: CGFloat) {
        self = CGAffineTransformTranslate(self, tx, ty)
    }
}
