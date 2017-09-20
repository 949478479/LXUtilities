//
//  NSTimer+LXExtension.h
//
//  Created by 从今以后 on 16/4/28.
//  Copyright © 2016年 从今以后. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (LXExtension)

+ (instancetype)lx_scheduleTimerWithTimeInterval:(NSTimeInterval)seconds
                                         repeats:(BOOL)repeats
                                      usingBlock:(void (^)(NSTimer *timer))block;

+ (instancetype)lx_timerWithTimeInterval:(NSTimeInterval)seconds
                                 repeats:(BOOL)repeats
                              usingBlock:(void (^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
