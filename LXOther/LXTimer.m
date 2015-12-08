//
//  LXTimer.m
//
//  Created by 从今以后 on 15/11/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LXTimer.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXTimer ()
@property (nonatomic) dispatch_source_t timerSource;
@end

@implementation LXTimer

#pragma mark - 工厂方法 -

+ (LXTimer *)timerWithInterval:(NSTimeInterval)timeInterval
                     tolerance:(NSTimeInterval)tolerance
                       handler:(void (^)(void))handler
{
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
    NSParameterAssert(target != nil);
    NSParameterAssert(selector != nil);

    LXTimer *timer = [[LXTimer alloc] initWithInterval:timeInterval tolerance:tolerance];

    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = selector;
    if (signature.numberOfArguments == 3) {
        [invocation setArgument:&timer atIndex:2];
    }

    __weak id weakTarget = target;
    [timer _configureTimerSourceWithHandler:^{
        [invocation invokeWithTarget:weakTarget];
    }];

    return timer;
}

#pragma mark - 公共接口 -

- (void)setPaused:(BOOL)paused
{
    NSAssert(_valid, @"定时器已失效！");

    if (paused == _paused) return;

    _paused = paused;

    paused ? dispatch_suspend(_timerSource) : dispatch_resume(_timerSource);
}

- (void)invalidate
{
    if (!_valid) return;

    _valid = NO;

    if (_paused) {
        dispatch_resume(_timerSource);
    }
    dispatch_source_cancel(_timerSource);
}

#pragma mark - 私有 -

- (void)dealloc
{
    [self invalidate];
}

- (instancetype)initWithInterval:(NSTimeInterval)timeInterval
                       tolerance:(NSTimeInterval)tolerance
{
    self = [super init];
    if (self) {
        _valid = YES;
        _tolerance = tolerance;
        _timeInterval = timeInterval;
        _timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    }
    return self;
}

- (void)_configureTimerSourceWithHandler:(dispatch_block_t)handler
{
    dispatch_source_set_timer(_timerSource, DISPATCH_TIME_NOW, _timeInterval * NSEC_PER_SEC, _tolerance * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timerSource, handler);
    dispatch_resume(_timerSource);
}

@end

NS_ASSUME_NONNULL_END
