//
//  UITableView+LXExtension.h
//
//  Created by 从今以后 on 16/6/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (LXExtension)

- (void)lx_reloadDataWithCompletion:(void (^)(void))completion;

- (nullable __kindof UITableViewCell *)lx_cellForSelectedRow;

- (NSArray<__kindof UITableViewCell *> *)lx_cellsForSelectedRows;

- (NSArray<NSIndexPath *> *)lx_allIndexPaths;

- (NSArray<NSIndexPath *> *)lx_indexPathsForSection:(NSInteger)section;

- (void)lx_selectRowAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths animated:(BOOL)animated;

/// 根据自动布局更新 tableHeaderView 的高度，可在块中更新子视图约束
- (void)lx_updateTableHeaderViewHeightWithLayoutConfiguration:(void (^_Nullable)(void))configuration NS_SWIFT_UNAVAILABLE("使用 lx.updateTableHeaderViewHeight(withLayoutConfiguration:) 替代.");
/// 根据自动布局更新 tableFooterView 的高度，可在块中更新子视图约束
- (void)lx_updateTableFooterViewHeightWithLayoutConfiguration:(void (^_Nullable)(void))configuration NS_SWIFT_UNAVAILABLE("使用 lx.updateTableFooterViewHeight(withLayoutConfiguration:) 替代.");

@end

NS_ASSUME_NONNULL_END
