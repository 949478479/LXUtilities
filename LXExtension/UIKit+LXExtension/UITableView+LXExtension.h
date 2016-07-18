//
//  UITableView+LXExtension.h
//
//  Created by 从今以后 on 16/6/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (LXExtension)

@property (nullable, nonatomic, readonly) __kindof UITableViewCell *lx_cellForSelectedRow;

@property (nullable, nonatomic, readonly) NSArray<__kindof UITableViewCell *> *lx_cellsForSelectedRows;

/// 根据自动布局更新 tableHeaderView 的高度，可在块中更新子视图约束
- (void)lx_updateTableHeaderViewHeight:(void (^_Nullable)(void))configuration;
/// 根据自动布局更新 tableFooterView 的高度，可在块中更新子视图约束
- (void)lx_updateTableFooterViewHeight:(void (^_Nullable)(void))configuration;

@end

NS_ASSUME_NONNULL_END
