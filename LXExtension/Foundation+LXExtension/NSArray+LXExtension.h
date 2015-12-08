//
//  NSArray+LXExtension.h
//
//  Created by 从今以后 on 15/10/4.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (LXExtension)

///--------------
/// @name 常用方法
///--------------

/**
 *  根据资源相对 `mainBundle` 的路径创建数组，资源名须带拓展名。
 */
+ (nullable instancetype)lx_arrayWithResourcePath:(NSString *)path;

///-------------------
/// @name 函数式便捷方法
///-------------------

- (instancetype)lx_filter:(BOOL (^)(ObjectType obj))filter;

- (instancetype)lx_map:(id _Nullable (^)(ObjectType obj, BOOL *stop))map;

@end

NS_ASSUME_NONNULL_END
