//
//  UIScrollView+LXExtension.swift
//  LXUtilitiesDemo
//
//  Created by 冠霖环如 on 2017/10/23.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UIScrollView {

    func scrollToTop(animated: Bool) {
        let offset: CGPoint
        if #available(iOS 11, *), base.contentInsetAdjustmentBehavior != .never {
            offset = CGPoint(x: 0, y: -base.adjustedContentInset.top)
        } else {
            offset = CGPoint(x: 0, y: -base.contentInset.top)
        }
        base.setContentOffset(offset, animated: animated)
    }
}
