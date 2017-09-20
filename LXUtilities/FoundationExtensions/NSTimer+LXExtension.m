//
//  NSTimer+LXExtension.m
//
//  Created by 从今以后 on 16/4/28.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "NSTimer+LXExtension.h"

@implementation NSTimer (LXExtension)

+ (instancetype)lx_scheduleTimerWithTimeInterval:(NSTimeInterval)seconds
                                         repeats:(BOOL)repeats
                                      usingBlock:(void (^)(NSTimer *timer))block
{
    NSTimer *timer = [self lx_timerWithTimeInterval:seconds repeats:repeats usingBlock:block];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    return timer;
}

+ (instancetype)lx_timerWithTimeInterval:(NSTimeInterval)inSeconds
                                 repeats:(BOOL)repeats
                              usingBlock:(void (^)(NSTimer *timer))block
{
    NSParameterAssert(block != nil);
    CFAbsoluteTime seconds = fmax(inSeconds, 0.0001);
    CFAbsoluteTime interval = repeats ? seconds : 0;
    CFAbsoluteTime fireDate = CFAbsoluteTimeGetCurrent() + seconds;
    return (__bridge_transfer NSTimer *)CFRunLoopTimerCreateWithHandler(NULL,
                                                                        fireDate,
                                                                        interval,
                                                                        0,
                                                                        0,
                                                                        (void(^)(CFRunLoopTimerRef))block);
}

@end
