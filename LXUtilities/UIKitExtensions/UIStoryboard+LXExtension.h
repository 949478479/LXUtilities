//
//  UIStoryboard+LXExtension.h
//
//  Created by 从今以后 on 16/3/5.
//  Copyright © 2016年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIStoryboard (LXExtension)

///---------------
/// @name 实例化方法
///---------------

#pragma mark - 实例化方法 -

/// 实例化指定故事板中的初始控制器
+ (__kindof UIViewController *)lx_instantiateInitialViewControllerWithStoryboardName:(NSString *)storyboardName;

/// 根据标识符实例化指定故事板中的控制器
+ (__kindof UIViewController *)lx_instantiateViewControllerWithIdentifier:(NSString *)identifier inStoryBoard:(NSString *)storyboardName;

@end

NS_ASSUME_NONNULL_END
