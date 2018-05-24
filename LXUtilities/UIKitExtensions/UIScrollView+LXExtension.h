//
//  UIScrollView+LXExtension.h
//
//  Created by 从今以后 on 2017/4/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LXExtension)

/// 是否已抵达顶部
- (BOOL)lx_isContentAtTop NS_SWIFT_UNAVAILABLE("use lx.isContentAtTop instead");
/// 是否已抵达底部
- (BOOL)lx_isContentAtBottom NS_SWIFT_UNAVAILABLE("use lx.isContentAtBottom instead");

/// 滚动到顶部
- (void)lx_scrollToTopAnimated:(BOOL)animated NS_SWIFT_UNAVAILABLE("use lx.scrollToTop(animated:) instead");
/// 滚动到底部
- (void)lx_scrollToBottomAnimated:(BOOL)animated NS_SWIFT_UNAVAILABLE("use lx.scrollToTop(animated:) instead");

@end
