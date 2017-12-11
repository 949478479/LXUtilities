//
//  NSObject+LXExtension.h
//
//  Created by 从今以后 on 15/9/14.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import Foundation;
#import "NSObject+LXIntrospection.h"

NS_ASSUME_NONNULL_BEGIN

/// 获取协议中声明的所有属性名称
NSArray<NSString *> *lx_protocol_propertyList(Protocol *protocol);

/// NSObject 的直接子类采纳此协议将会覆盖 -[NSObject description] 方法，在默认实现上附带实例变量名和值
@protocol LXDescriptionProtocol <NSObject>
@end

@interface NSObject (LXExtension)

///--------------
/// @name 方法交换
///--------------

+ (void)lx_exchangeMethodWithOriginalSelector:(SEL)originalSel swizzledSelector:(SEL)swizzledSel;

///--------------
/// @name 关联对象
///--------------

/// 使用 retain 语义和指定 key 设置对应的关联值。
- (void)lx_setRetainAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key;
/// 使用 copy 语义和指定 key 设置对应的关联值。
- (void)lx_setCopyAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key;
/// 使用 weak 语义和指定 key 设置对应的关联值。
- (void)lx_setWeakAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key;
/// 根据 key 获取对应的关联值。
- (nullable id)lx_associatedValueForKey:(const void * _Nonnull)key;
/// 移除所有关联值。
- (void)lx_removeAllAssociatedValues;

/// 使用 retain 语义和指定 key 设置对应的关联值。
+ (void)lx_setRetainAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key;
/// 使用 copy 语义和指定 key 设置对应的关联值。
+ (void)lx_setCopyAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key;
/// 使用 weak 语义和指定 key 设置对应的关联值。
+ (void)lx_setWeakAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key;
/// 根据 key 获取对应的关联值。
+ (nullable id)lx_associatedValueForKey:(const void * _Nonnull)key;
/// 移除所有关联值。
+ (void)lx_removeAllAssociatedValues;

///------------------
/// @name KVO 相关方法
///------------------

- (void)lx_removeAllObservers;

@end

NS_ASSUME_NONNULL_END
