//
//  UITextView+LXExtension.swift
//  这到底是什么鬼
//
//  Created by 不知什么人 on 2021/2/24.
//  Copyright © 2021 XinMo. All rights reserved.
//

import UIKit

extension Swifty where Base: UITextView {

    func rects(forCharacterRange range: Range<String.Index>) -> [CGRect] {
        guard let range = base.text.lx.nsRange(from: range) else { return [] }

        var rects = [CGRect]()
        let glyphRange = base.layoutManager.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
        base.layoutManager.enumerateEnclosingRects(forGlyphRange: glyphRange, withinSelectedGlyphRange: NSRange(location: NSNotFound, length: 0), in: base.textContainer) { (rect, _) in
            var rect = rect
            rect.origin.x += base.textContainerInset.left
            rect.origin.y += base.textContainerInset.top
            rects.append(rect)
        }
        return rects
    }

    func link(for point: CGPoint) -> URL? {
        var point = point
        point.x -= base.textContainerInset.left
        point.y -= base.textContainerInset.top

        var f: CGFloat = 0
        let index = base.layoutManager.characterIndex(for: point, in: base.textContainer, fractionOfDistanceBetweenInsertionPoints: &f)
        let attributes = base.attributedText.attributes(at: index, effectiveRange: nil)

        // if no character is under the point, the nearest character is returned.
        // 试验发现可以通过这种方式过滤一下这种情况
        guard f > 0, f < 1 else { return nil }

        if let url = attributes[.link] as? URL {
            return url
        }

        if let string = attributes[.link] as? String {
            return URL(string: string)
        }

        return nil
    }
}
