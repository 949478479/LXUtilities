//
//  NSDate+LXExtension.m
//
//  Created by 从今以后 on 15/10/1.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "NSDate+LXExtension.h"

@implementation NSDate (LXExtension)

- (BOOL)lx_isThisMinute
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];

    NSAssert(timeInterval >= 0, @"测试时间晚于当前时间.");

    return timeInterval < 60;
}

- (BOOL)lx_isThisHour
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];

    NSAssert(timeInterval >= 0, @"测试时间晚于当前时间.");

    return timeInterval < 3600;
}

- (BOOL)lx_isYesterday
{
    return [[NSCalendar currentCalendar] isDateInYesterday:self];
}

- (BOOL)lx_isToday
{
    return [[NSCalendar currentCalendar] isDateInToday:self];
}

- (BOOL)lx_isTomorrow
{
    return [[NSCalendar currentCalendar] isDateInTomorrow:self];
}

- (BOOL)lx_isThisYear
{
    return [[NSCalendar currentCalendar] isDate:self
                                    equalToDate:[NSDate date]
                              toUnitGranularity:NSCalendarUnitYear];
}

- (BOOL)lx_isWeekend
{
    return [[NSCalendar currentCalendar] isDateInWeekend:self];
}

- (BOOL)lx_isSameDayAsDate:(NSDate *)date
{
    return [[NSCalendar currentCalendar] isDate:self inSameDayAsDate:date];
}


- (NSInteger)lx_yearsToNow
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear
                                            fromDate:self
                                              toDate:[NSDate date]
                                             options:0] year];
}

- (dispatch_time_t)lx_dispatchTime
{
    /** 获取从 1970 到 date 的时间间隔,单位为秒 */
    NSTimeInterval interval = [self timeIntervalSince1970];

    /** 利用 modf 函数获取整数秒 second, 和小数秒 subSecond. */
    double second, subSecond;
    subSecond = modf(interval, &second);

    /** 构造 timespec 结构体.第一个成员是秒,第二个是纳秒,所以要乘以 NSEC_PER_SEC. */
    struct timespec when = { second, subSecond * NSEC_PER_SEC };

    /** 利用 timespec 结构体数据生成时间并返回 */
    return dispatch_walltime(&when, 0);
}

@end
