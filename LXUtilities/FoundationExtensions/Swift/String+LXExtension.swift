//
//  String+LXExtension.swift
//
//  Created by 从今以后 on 2017/10/12.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import Foundation

extension String: SwiftyProtocol {}

extension Swifty where Base == String {
    
    var url: URL? {
        return URL(string: base)
    }

    func nsRange(of string: String) -> NSRange? {
        base.range(of: string).flatMap { nsRange(from: $0) }
    }

    func nsRange(from range: Range<String.Index>) -> NSRange? {
        let utf16 = base.utf16
        guard let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) else {
            return nil
        }
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from), length: utf16.distance(from: from, to: to))
    }

    func range(from nsRange: NSRange) -> Range<String.Index>? {
        let utf16 = base.utf16
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: base),
            let to = String.Index(to16, within: base)
        else {
            return nil
        }
        return from..<to
    }
}
