//
//  UIScrollView+LXExtension.m
//
//  Created by 从今以后 on 2017/4/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import "UIScrollView+LXExtension.h"

@implementation UIScrollView (LXExtension)

- (BOOL)lx_atTop {
    return self.contentOffset.y + self.contentInset.top <= 0;
}

- (BOOL)lx_atBottom
{
    CGFloat height = CGRectGetHeight(self.bounds);
    NSInteger height1 = self.contentOffset.y - self.contentInset.bottom + height;
    NSInteger contentSizeHeight = self.contentSize.height;
    if (height1 >= contentSizeHeight) {
        return YES;
    }
    NSInteger height2 = height - self.contentInset.top - self.contentInset.bottom;
    if (height2 >= contentSizeHeight) {
        return YES;
    }
    return NO;
}

- (void)lx_scrollToTopAnimated:(BOOL)animated {
    [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:animated];
}

- (void)lx_scrollToBottomAnimated:(BOOL)animated {
    [self scrollRectToVisible:CGRectMake(0, self.contentSize.height - 1, 1, 1) animated:animated];
}

@end
