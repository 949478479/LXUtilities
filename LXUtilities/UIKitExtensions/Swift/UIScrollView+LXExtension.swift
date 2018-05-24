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
        guard !isContentAtTop() else { return }
        
        let offset: CGPoint = {
            if #available(iOS 11, *) {
                return CGPoint(x: 0, y: -base.adjustedContentInset.top)
            }
            return CGPoint(x: 0, y: -base.contentInset.top)
        }()

        base.setContentOffset(offset, animated: animated)
    }

    func scrollToBottom(animated: Bool) {
        guard !isContentAtBottom() else { return }

        let offset: CGPoint = {
            if #available(iOS 11, *) {
                return CGPoint(x: 0, y: base.contentSize.height - base.bounds.height + base.adjustedContentInset.bottom)
            }
            return CGPoint(x: 0, y: base.contentSize.height - base.bounds.height + base.contentInset.bottom)
        }()

        base.setContentOffset(offset, animated: animated)
    }
}
