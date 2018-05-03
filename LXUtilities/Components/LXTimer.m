//
//  LXTimer.m
//
//  Created by 从今以后 on 15/11/30.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "LXTimer.h"
#import "LXMacro.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LXTimer
{
    BOOL _isSuspended;
    dispatch_source_t _timerSource;
}

- (void)dealloc
{
    [self invalidate];
}

#pragma mark - 初始化

- (instancetype)initWithInterval:(NSTimeInterval)timeInterval
                       tolerance:(NSTimeInterval)tolerance
{
    self = [super init];
    if (self) {
        _isValid = YES;
        _isSuspended = YES;
        _tolerance = tolerance;
        _timeInterval = timeInterval;
        _timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    }
    return self;
}

#pragma mark - 工厂方法

+ (LXTimer *)timerWithInterval:(NSTimeInterval)timeInterval
                     tolerance:(NSTimeInterval)tolerance
                       handler:(void (^)(void))handler
{
    NSParameterAssert(timeInterval >= 0);
    NSParameterAssert(tolerance >= 0);
    NSParameterAssert(handler != nil);

    LXTimer *timer = [[LXTimer alloc] initWithInterval:timeInterval tolerance:tolerance];
    [timer _configureTimerSourceWithHandler:handler];
    return timer;
}

+ (LXTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                         tolerance:(NSTimeInterval)tolerance
                            target:(id)target
                          selector:(SEL)selector
{
    NSParameterAssert(timeInterval >= 0);
    NSParameterAssert(tolerance >= 0);
    NSParameterAssert(target != nil);
    NSParameterAssert(selector != nil);

    LXTimer *timer = [[LXTimer alloc] initWithInterval:timeInterval tolerance:tolerance];

    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
	[invocation setSelector:selector];
	[invocation setArgument:&timer atIndex:2];

    __weak id weakTarget = target;
    [timer _configureTimerSourceWithHandler:^{
		__strong typeof(weakTarget) strongTarget = weakTarget;
        if (strongTarget) {
            [invocation invokeWithTarget:strongTarget];
        }
    }];

    return timer;
}

#pragma mark - 配置定时器

- (void)_configureTimerSourceWithHandler:(dispatch_block_t)handler
{
    dispatch_source_set_timer(_timerSource,
                              DISPATCH_TIME_NOW,
                              _timeInterval * NSEC_PER_SEC,
                              _tolerance * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timerSource, handler);
}

#pragma mark - 启动废止

- (void)start
{
    if (!_isStarted) {
        _isStarted = YES;
        __weak typeof(self) weakSelf = self;
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			__strong typeof(weakSelf) self = weakSelf;
			if (self) {
                dispatch_resume(self->_timerSource);
                self->_isSuspended = NO;
			}
		});
    }
}

- (void)invalidate
{
    if (!_isValid) {
        return;
    }
    _isValid = NO;

    dispatch_source_cancel(_timerSource);
    if (_isSuspended) {
        dispatch_resume(_timerSource);
    }
    _timerSource = nil;
}

@end

NS_ASSUME_NONNULL_END
