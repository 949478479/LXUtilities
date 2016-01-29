//
//  NSManagedObjectModel+LXExtension.h
//
//  Created by 从今以后 on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

@import CoreData;

@interface NSManagedObjectModel (LXExtension)

/// NSManagedObjectModel 对应的 .xcdatamodeld 文件名。
- (NSString *)lx_modelName;

/// 获取应用程序包中所有 .xcdatamodeld 文件的路径。
+ (NSArray<NSString *> *)lx_allModelPaths;

/// 获取指定 .xcdatamodel 文件的所有版本的文件的路径
+ (NSArray<NSString *> *)lx_modelPathsForModelName:(NSString *)modelName;

@end
