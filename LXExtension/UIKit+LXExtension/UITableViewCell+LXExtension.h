//
//  UITableViewCell+LXExtension.h
//
//  Created by 从今以后 on 16/4/3.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (LXExtension)

/// 使用类名作为重用标识符来获取单元格
+ (instancetype)lx_cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
