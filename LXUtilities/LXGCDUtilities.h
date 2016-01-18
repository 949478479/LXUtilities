//
//  LXGCDUtilities.h
//
//  Created by 从今以后 on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 *  创建一个基于 @c dispatch_source_t 的在主线程工作的定时器。
 *
 *  @param interval      触发时间间隔。
 *  @param leeway        可容忍的触发时间偏差。
 *  @param handler       定时器触发时执行的 block。
 *  @param cancelHandler 定时器取消时执行的 block。
 *
 *  @return 未激活的 @c dispatch_source_t，需手动调用 @c dispatch_resume() 函数激活.
 */
dispatch_source_t lx_dispatch_source_timer(NSTimeInterval secondInterval,
                                           NSTimeInterval secondLeeway,
                                           dispatch_block_t handler,
                                           _Nullable dispatch_block_t cancelHandler);

void lx_dispatch_after(NSTimeInterval delayInSeconds, dispatch_block_t handler);

NS_ASSUME_NONNULL_END
