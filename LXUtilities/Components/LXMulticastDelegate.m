//
//  LXMulticastDelegate.m
//
//  Created by 从今以后 on 15/9/25.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import ObjectiveC.runtime;
#import "LXMulticastDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LXMulticastDelegate {
    Protocol *_protocol;
    NSHashTable *_delegates;
    NSMapTable *_introspectionFlags;
    NSMapTable *_methodSignatureCache;
}

#pragma mark - 初始化 -

- (instancetype)initWithProtocol:(Protocol *)protocol
{
    NSAssert(protocol != nil, @"初始化时必须指定协议");

    _protocol = protocol;

    // 用于保存代理对象
    _delegates =
    [NSHashTable hashTableWithOptions:
     NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality];

    // 用于记录代理对象能否响应选择器，代理对象为键，NSMapTable 为值
    _introspectionFlags =
    [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality
                          valueOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality];

    // 用于缓存已生成的方法签名，选择器为键，对应方法签名为值
    _methodSignatureCache =
    [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory|NSPointerFunctionsOpaquePersonality
                          valueOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPointerPersonality];

    return self;
}

#pragma mark - 添加、移除代理成员 -

- (void)addDelegate:(id)delegate
{
    NSAssert(delegate != nil, @"不能添加空值作为代理成员");
    NSAssert([delegate conformsToProtocol:_protocol], @"添加的代理成员必须符合协议");

    if (![_delegates containsObject:delegate]) {
        [_delegates addObject:delegate];
        NSHashTable *selCache = [NSHashTable hashTableWithOptions:
                                 NSPointerFunctionsOpaqueMemory|NSPointerFunctionsOpaquePersonality];
        [_introspectionFlags setObject:selCache forKey:delegate];
    }
}

- (void)removeDelegate:(id)delegate
{
    NSAssert(delegate != nil, @"移除代理成员时不能传入空值");

    if ([_delegates containsObject:delegate]) {
        [_delegates removeObject:delegate];
        [_introspectionFlags removeObjectForKey:delegate];
    }
}

- (void)removeAllDelegates
{
    [_delegates removeAllObjects];
    [_introspectionFlags removeAllObjects];
}

#pragma mark - 消息转发 -

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    // 优先查找缓存
    NSMethodSignature *methodSignature = [_methodSignatureCache objectForKey:(__bridge id)(void *)sel];
    if (methodSignature) {
        return methodSignature;
    }

    // 查找 required 协议方法
    struct objc_method_description desc = protocol_getMethodDescription(_protocol, sel, YES, YES);

    // 若未找到，进一步查找 option 协议方法
    if (!desc.types) {
        desc = protocol_getMethodDescription(_protocol, sel, NO, YES);
    }

    // 若找到，生成方法签名，并存入缓存
    if (desc.types) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:desc.types];
        [_methodSignatureCache setObject:methodSignature forKey:(__bridge id)(void *)sel];
        return methodSignature;
    }

    /* 返回 nil 将直接导致如下异常。为了能显示类名，手动抛出异常。
     *** Terminating app due to uncaught exception 'NSInvalidArgumentException',
     reason: '*** -[NSProxy doesNotRecognizeSelector:objectAtIndex:] called!' */
    [NSException raise:NSInvalidArgumentException
                format:@"*** -[%@ doesNotRecognizeSelector:%s] called!",
     object_getClass(self), sel_getName(sel)];

    return nil;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    SEL sel = invocation.selector;
    for (id delegate in _delegates) {
        // 若该代理已经判断过能否响应，则直接调用，否则判断能否响应，若能响应则记录
        NSHashTable *selCache = [_introspectionFlags objectForKey:delegate];
        if ([selCache containsObject:(__bridge id)(void *)sel]) {
            [invocation invokeWithTarget:delegate];
        } else if ([delegate respondsToSelector:sel]) {
            [selCache addObject:(__bridge id)(void *)sel];
            [invocation invokeWithTarget:delegate];
        }
    }
}

#pragma mark - 调试

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p>\n%@",
            object_getClass(self), self, _delegates.allObjects];
}

@end

NS_ASSUME_NONNULL_END
