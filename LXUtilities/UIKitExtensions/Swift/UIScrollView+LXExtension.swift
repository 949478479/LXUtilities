//
//  UIScrollView+LXExtension.swift
//
//  Created by 从今以后 on 2017/10/23.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UIScrollView {

    func isContentAtTop() -> Bool {
        if #available(iOS 11, *) {
            return base.contentOffset.y + base.adjustedContentInset.top <= 0
        }
        return base.contentOffset.y + base.contentInset.top <= 0
    }

    func isContentAtBottom() -> Bool {
        let contentInsetBottom: CGFloat = {
            if #available(iOS 11, *) {
                return base.adjustedContentInset.bottom
            }
            return base.contentInset.bottom
        }()

        if base.contentOffset.y + base.bounds.height - contentInsetBottom >= base.contentSize.height {
            return true
        }

        return false
    }

    func scrollToTop(animated: Bool) {
        guard !isContentAtTop() else {
            return
        }
        base.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: animated)
    }

    func scrollToBottom(animated: Bool) {
        guard !isContentAtBottom() else {
            return
        }
        let y = base.contentSize.height - 1
        base.scrollRectToVisible(CGRect(x: 0, y: y, width: 1, height: 1), animated: animated)
    }
}
