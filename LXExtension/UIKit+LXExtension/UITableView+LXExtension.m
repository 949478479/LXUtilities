//
//  UITableView+LXExtension.m
//
//  Created by 从今以后 on 16/6/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UIView+LXExtension.h"
#import "UITableView+LXExtension.h"

@implementation UITableView (LXExtension)

- (UITableViewCell *)lx_cellForSelectedRow
{
    return [self cellForRowAtIndexPath:[self indexPathForSelectedRow]];
}

- (NSArray<UITableViewCell *> *)lx_cellsForSelectedRows
{
    NSMutableArray *cells = [NSMutableArray new];
    for (NSIndexPath *indexPath in [self indexPathsForSelectedRows]) {
        [cells addObject:[self cellForRowAtIndexPath:indexPath]];
    }
    return [cells copy];
}

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

- (void)lx_updateTableFooterViewHeight:(void (^)(void))configuration
{
    UIView *footerView = self.tableFooterView;

    // 添加宽度约束来从而构成完整的约束来计算头视图高度
    footerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthConstraint =
    [NSLayoutConstraint constraintWithItem:footerView
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:0
                                multiplier:1
                                  constant:self.lx_width];
    [footerView addConstraint:widthConstraint];

    // 让调用方有机会更新子视图约束
    !configuration ?: configuration();

    // 通过自动布局计算头视图高度，然后移除刚添加的约束
    CGFloat height = [footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [footerView removeConstraint:widthConstraint];

    // 回归传统 frame 布局后设置高度
    footerView.translatesAutoresizingMaskIntoConstraints = YES;
    footerView.lx_height = height;

    self.tableFooterView = footerView;
}

@end
