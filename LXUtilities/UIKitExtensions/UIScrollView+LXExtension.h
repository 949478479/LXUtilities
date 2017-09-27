//
//  UIScrollView+LXExtension.h
//
//  Created by 从今以后 on 2017/4/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LXExtension)

/// 是否已抵达顶部
- (BOOL)lx_atTop;
/// 是否已抵达底部
- (BOOL)lx_atBottom;

/// 滚动到顶部
- (void)lx_scrollToTopAnimated:(BOOL)animated;
/// 滚动到底部
- (void)lx_scrollToBottomAnimated:(BOOL)animated;

@end
