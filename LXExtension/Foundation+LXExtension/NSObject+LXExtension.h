//
//  NSObject+LXExtension.h
//
//  Created by 从今以后 on 15/9/14.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import Foundation;
#import "NSObject+LXIntrospection.h"

NS_ASSUME_NONNULL_BEGIN

/// NSObject 的直接子类采纳此协议将会覆盖 -[NSObject description] 方法，在默认实现上附带实例变量名和值
@protocol LXDescriptionProtocol <NSObject>
@end

@interface NSObject (LXExtension)

///--------------
/// @name 关联对象
///--------------

/// 使用 retain 语义根据指定 key 关联值
- (void)lx_associateValue:(nullable id)value forKey:(NSString *)key;
/// 使用 copy 语义根据指定 key 关联值
- (void)lx_associateCopyOfValue:(nullable id)value forKey:(NSString *)key;
/// 使用 weak 语义根据指定 key 关联值
- (void)lx_weaklyAssociateValue:(nullable id)value forKey:(NSString *)key;
/// 根据 key 获取对应的关联值
- (nullable id)lx_associatedValueForKey:(NSString *)key;
/// 根据 key 获取对应的 weak 语义关联值
- (nullable id)lx_weakAssociatedValueForKey:(NSString *)key;
/// 移除所有关联值
- (void)lx_removeAllAssociatedObjects;

/// 使用 retain 语义根据指定 key 关联值
+ (void)lx_associateValue:(nullable id)value forKey:(NSString *)key;
/// 使用 copy 语义根据指定 key 关联值
+ (void)lx_associateCopyOfValue:(nullable id)value forKey:(NSString *)key;
/// 使用 weak 语义根据指定 key 关联值
+ (void)lx_weaklyAssociateValue:(nullable id)value forKey:(NSString *)key;
/// 根据 key 获取对应的关联值
+ (nullable id)lx_associatedValueForKey:(NSString *)key;
/// 根据 key 获取对应的 weak 语义关联值
+ (nullable id)lx_weakAssociatedValueForKey:(NSString *)key;
/// 移除所有关联值
+ (void)lx_removeAllAssociatedObjects;

///------------------
/// @name KVO 相关方法
///------------------

- (void)lx_removeAllObservers;

@end

NS_ASSUME_NONNULL_END
