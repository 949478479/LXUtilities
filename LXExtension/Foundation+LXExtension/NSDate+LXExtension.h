//
//  NSDate+LXExtension.h
//
//  Created by 从今以后 on 15/10/1.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LXExtension)

- (BOOL)lx_isThisMinute;
- (BOOL)lx_isThisHour;
- (BOOL)lx_isYesterday NS_AVAILABLE_IOS(8_0);
- (BOOL)lx_isToday     NS_AVAILABLE_IOS(8_0);
- (BOOL)lx_isTomorrow  NS_AVAILABLE_IOS(8_0);
- (BOOL)lx_isThisYear  NS_AVAILABLE_IOS(8_0);
- (BOOL)lx_isWeekend   NS_AVAILABLE_IOS(8_0);

- (BOOL)lx_isSameDayAsDate:(NSDate *)date NS_AVAILABLE_IOS(8_0);

- (NSInteger)lx_yearsToNow;

@end

NS_ASSUME_NONNULL_END
