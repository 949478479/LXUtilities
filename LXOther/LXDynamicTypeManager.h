//
//  LXDynamicTypeManager.h
//
//  Created by 从今以后 on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface LXDynamicTypeManager : NSObject

+ (void)registerBlock:(void (^)(void))block;

+ (void)registerView:(UIView *)view usingBlock:(void (^)(void))block;

+ (void)removeView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
