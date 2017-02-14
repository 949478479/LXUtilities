//
//  LXMulticastDelegate.h
//
//  Created by 从今以后 on 15/9/25.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface LXMulticastDelegate : NSProxy

/// 用指定协议初始化多路代理，代理成员必须符合协议
- (instancetype)initWithProtocol:(Protocol *)protocol;

/// 以弱引用添加代理成员
- (void)addDelegate:(id)delegate;

/// 移除指定代理成员
- (void)removeDelegate:(id)delegate;

/// 移除全部代理成员
- (void)removeAllDelegates;

@end

NS_ASSUME_NONNULL_END
