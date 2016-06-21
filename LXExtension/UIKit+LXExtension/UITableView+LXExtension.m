//
//  UITableView+LXExtension.m
//
//  Created by 从今以后 on 16/6/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UIView+LXExtension.h"
#import "UITableView+LXExtension.h"

@implementation UITableView (LXExtension)

- (void)lx_updateTableHeaderViewHeight:(void (^)(void))configuration
{
    UIView *headerView = self.tableHeaderView;

    // 添加宽度约束来从而构成完整的约束来计算头视图高度
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthConstraint =
    [NSLayoutConstraint constraintWithItem:headerView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:0
                                multiplier:1
                                  constant:self.lx_width];
    [headerView addConstraint:widthConstraint];

    // 让调用方有机会更新子视图约束
    !configuration ?: configuration();

    // 通过自动布局计算头视图高度，然后移除刚添加的约束
    CGFloat height = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [headerView removeConstraint:widthConstraint];

    // 回归传统 frame 布局后设置高度
    headerView.translatesAutoresizingMaskIntoConstraints = YES;
    headerView.lx_height = height;

    self.tableHeaderView = headerView;
}

@end
