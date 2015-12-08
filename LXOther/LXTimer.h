//
//  LXTimer.h
//
//  Created by 从今以后 on 15/11/30.
//  Copyright © 2015年 apple. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface LXTimer : NSObject

/**
 *  在定时器有效的情况下挂起或恢复定时器。
 */
@property (nonatomic, getter=isPaused) BOOL paused;

/**
 *  定时器是否有效。
 */
@property (nonatomic, readonly, getter=isValid) BOOL valid;

/**
 *  定时器的触发间隔。
 */
@property (nonatomic, readonly) NSTimeInterval timeInterval;

/**
 *  定时器的宽容度。
 */
@property (nonatomic, readonly) NSTimeInterval tolerance;

/**
 *  令定时器失效。
 */
- (void)invalidate;

/**
 *  创建一个工作在主线程的定时器，不受触摸事件影响。定时器需被强引用。
 *
 *  @param timeInterval 定时器的触发间隔。
 *  @param tolerance    定时器的宽容度。
 *  @param handler      定时器触发时在主线程调用此 block。
 */
+ (LXTimer *)timerWithInterval:(NSTimeInterval)timeInterval
                     tolerance:(NSTimeInterval)tolerance
                       handler:(void (^)(void))handler;

/**
 *  创建一个工作在主线程的定时器，不受触摸事件影响。定时器需被强引用。
 *
 *  @param timeInterval 定时器的触发间隔。
 *  @param tolerance    定时器的宽容度。
 *  @param target       @c selector 消息的接收者，定时器不会对其造成强引用。
 *  @param selector     定时器触发时向 @c target 发送此消息。
 */
+ (LXTimer *)timerWithTimeInterval:(NSTimeInterval)timeInterval
                         tolerance:(NSTimeInterval)tolerance
                            target:(id)target
                          selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
