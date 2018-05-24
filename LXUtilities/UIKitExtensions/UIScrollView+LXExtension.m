//
//  UIScrollView+LXExtension.m
//
//  Created by 从今以后 on 2017/4/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import "UIScrollView+LXExtension.h"

@implementation UIScrollView (LXExtension)

- (BOOL)lx_isContentAtTop
{
    if (@available(iOS 11, *)) {
        return self.contentOffset.y + self.adjustedContentInset.top <= 0;
    }
    return self.contentOffset.y + self.contentInset.top <= 0;
}

- (BOOL)lx_isContentAtBottom
{
    CGFloat contentInsetBottom;
    if (@available(iOS 11, *)) {
        contentInsetBottom = self.adjustedContentInset.bottom;
    } else {
        contentInsetBottom = self.contentInset.bottom;
    }

    if (self.contentOffset.y + self.bounds.size.height - contentInsetBottom >= self.contentSize.height) {
        return YES;
    }

    return NO;
}

- (void)lx_scrollToTopAnimated:(BOOL)animated
{
    CGPoint offset;
    if (@available(iOS 11.0, *)) {
        offset = CGPointMake(0, -self.adjustedContentInset.top);
    } else {
        offset = CGPointMake(0, -self.contentInset.top);
    }
    [self setContentOffset:offset animated:animated];
}

- (void)lx_scrollToBottomAnimated:(BOOL)animated
{
    CGPoint offset;
    if (@available(iOS 11.0, *)) {
        offset = CGPointMake(0, self.contentSize.height - self.bounds.size.height + self.adjustedContentInset.bottom);
    } else {
        offset = CGPointMake(0, self.contentSize.height - self.bounds.size.height + self.contentInset.bottom);
    }
    [self setContentOffset:offset animated:animated];
}

@end
