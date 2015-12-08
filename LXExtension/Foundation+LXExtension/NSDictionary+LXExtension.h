//
//  NSDictionary+LXExtension.h
//
//  Created by 从今以后 on 15/10/10.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (LXExtension)

///-------------------
/// @name 函数式便捷方法
///-------------------

- (NSArray *)lx_map:(id _Nullable (^)(KeyType key, ObjectType obj))map;

- (instancetype)lx_filter:(BOOL (^)(KeyType key, ObjectType obj))filter;

@end

NS_ASSUME_NONNULL_END
