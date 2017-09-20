//
//  NSDictionary+LXExtension.h
//
//  Created by 从今以后 on 15/10/10.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (LXExtension)

///----------------
/// @name 实例化方法
///----------------

/// 根据资源相对 @c mainBundle 的路径创建字典，资源名须带拓展名。
+ (nullable NSDictionary<KeyType, ObjectType> *)lx_dictionaryWithResourcePath:(NSString *)path;

///-------------------
/// @name 函数式便捷方法
///-------------------

- (NSMutableArray *)lx_map:(id _Nullable (^)(__unsafe_unretained KeyType key, __unsafe_unretained ObjectType obj))transform;
- (NSMutableDictionary<KeyType, id> *)lx_mapValues:(id (^)(__unsafe_unretained KeyType key, __unsafe_unretained ObjectType obj))transform;
- (NSMutableDictionary<KeyType, ObjectType> *)lx_filter:(BOOL (^)(__unsafe_unretained KeyType key, __unsafe_unretained ObjectType obj))filter;

///-----------
/// @name 其他
///-----------

/// 判断字典是否有元素
- (BOOL)lx_hasElement;

/// 生成 JSON 字符串
- (nullable NSString *)lx_JSON;

@end

@interface NSMutableDictionary<KeyType, ObjectType> (LXExtension)

/**
 * 使用如下两个方法创建可变字典：
 *
 * @code
 *+[NSDictionary(NSSharedKeySetDictionary) sharedKeySetForKeys:]
 *+[NSMutableDictionary(NSSharedKeySetDictionary) dictionaryWithSharedKeySet:]
 * @endcode
 *
 * @note 共享键字典总是可变的，即使使用 @c -[NSMutableDictionary copy]。
 */
+ (NSMutableDictionary<KeyType, ObjectType> *)dictionaryWithSharedKeys:(NSArray<KeyType<NSCopying>> *)keys;

@end

NS_ASSUME_NONNULL_END
