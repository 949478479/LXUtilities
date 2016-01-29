//
//  LXMigrationManager.h
//
//  Created by 从今以后 on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

@import Foundation;
@class NSManagedObjectModel;

NS_ASSUME_NONNULL_BEGIN

@interface LXMigrationManager : NSObject

/// 迁移当前数据库，使之兼容指定数据模型。此方法优先查找 `mainBundle` 中的映射文件，再尝试自动生成映射文件。
- (BOOL)progressivelyMigrateStoreFromURL:(NSURL *)sourceStoreURL
							toFinalModel:(NSManagedObjectModel *)finalModel
								   error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
