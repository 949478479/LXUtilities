//
//  UITableView+LXExtension.m
//
//  Created by 从今以后 on 16/6/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UIView+LXExtension.h"
#import "UITableView+LXExtension.h"

@implementation UITableView (LXExtension)

- (void)lx_reloadDataWithCompletion:(void (^)(void))completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        completion();
    }];
    [self reloadData];
    [CATransaction commit];
}

- (UITableViewCell *)lx_cellForSelectedRow {
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

- (NSArray<NSIndexPath *> *)lx_allIndexPaths
{
    NSInteger countOfIndexPaths = 0;
    NSInteger countOfSections = [self numberOfSections];
    for (NSInteger section = 0; section < countOfSections; ++section) {
       countOfIndexPaths += [self numberOfRowsInSection:section];
    }
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:countOfIndexPaths];
    for (NSInteger section = 0; section < countOfSections; ++section) {
        NSInteger countOfRows = [self numberOfRowsInSection:section];
        for (NSInteger row = 0; row < countOfRows; ++row) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
        }
    }
    return [indexPaths copy];
}

- (NSArray<NSIndexPath *> *)lx_indexPathsInSection:(NSInteger)section
{
    NSInteger countOfRows = [self numberOfRowsInSection:section];
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:countOfRows];
    for (NSInteger row = 0; row < countOfRows; ++row) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
    }
    return [indexPaths copy];
}

- (void)lx_selectRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated
{
    [self beginUpdates];
    for (NSIndexPath *indexPath in indexPaths) {
        [self selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionNone];
    }
    [self endUpdates];
}

void _lx_updateTableHeaderOrFooterViewHeight(UITableView *tableView, BOOL isHeader, void (^configuration)(void))
{
	UIView *headerOrFooterView = isHeader ? tableView.tableHeaderView : tableView.tableFooterView;

	// 添加宽度约束来从而构成完整的约束来计算视图高度
	headerOrFooterView.translatesAutoresizingMaskIntoConstraints = NO;
	NSLayoutConstraint *widthConstraint =
	[NSLayoutConstraint constraintWithItem:headerOrFooterView
								 attribute:NSLayoutAttributeWidth
								 relatedBy:NSLayoutRelationEqual
									toItem:nil
								 attribute:0
								multiplier:1
								  constant:tableView.lx_width];
	[headerOrFooterView addConstraint:widthConstraint];

	// 让调用方有机会更新子视图约束
	!configuration ?: configuration();

	// 通过自动布局计算视图高度，然后移除刚添加的约束
	CGFloat height = [headerOrFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
	[headerOrFooterView removeConstraint:widthConstraint];

	// 回归传统 frame 布局后设置高度
	headerOrFooterView.translatesAutoresizingMaskIntoConstraints = YES;
	headerOrFooterView.lx_height = height;

	if (isHeader) {
		tableView.tableHeaderView = headerOrFooterView;
	} else {
		tableView.tableFooterView = headerOrFooterView;
	}
}

- (void)lx_updateTableHeaderViewHeightWithLayoutConfiguration:(void (^)(void))configuration {
	_lx_updateTableHeaderOrFooterViewHeight(self, YES, configuration);
}

- (void)lx_updateTableFooterViewHeightWithLayoutConfiguration:(void (^)(void))configuration {
    _lx_updateTableHeaderOrFooterViewHeight(self, NO, configuration);
}

@end
