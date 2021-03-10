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
}
