//
//  MBProgressHUD+LXExtension.h
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (LXExtension)

///-----------------------
/// @name 短暂显示纯文本 HUD
///-----------------------

#pragma mark - 短暂显示纯文本 HUD -

/// 在主窗口上短暂显示纯文本 HUD 并自动移除
+ (MBProgressHUD *)lx_showTextHUDWithText:(NSString *)text;

/// 在指定父视图上显示纯文本 HUD 并自动移除
+ (MBProgressHUD *)lx_showTextHUDWithText:(NSString *)text toView:(UIView *)view;

///-----------------------------------------
/// @name 持续显示带蒙版的原生活动指示器风格的 HUD
///-----------------------------------------

#pragma mark - 持续显示带蒙版的原生活动指示器风格的 HUD -

/// 在主窗口上持续显示原生活动指示器风格的 HUD，附带蒙版效果，需要手动移除
+ (MBProgressHUD *)lx_showActivityIndicatorWithMessage:(nullable NSString *)message;

/// 在指定父视图上持续显示原生活动指示器风格的 HUD，附带蒙版效果，需要手动移除
+ (MBProgressHUD *)lx_showActivityIndicatorWithMessage:(nullable NSString *)message toView:(UIView *)view;

///--------------------------
/// @name 短暂显示自定义图标 HUD
///--------------------------

#pragma mark - 短暂显示自定义图标 HUD -

/// 在指定父视图上短暂显示附带自定义图标的 HUD
+ (void)lx_show:(nullable NSString *)text icon:(NSString *)icon view:(UIView *)view;

///--------------------------
/// @name 持续显示环形进度条 HUD
///--------------------------

#pragma mark - 持续显示环形进度条 HUD -

/// 在主窗口上持续显示环形进度条样式的无蒙版 HUD，需手动更新 `progress` 属性，并隐藏 HUD
+ (MBProgressHUD *)lx_showProgressHUDWithText:(nullable NSString *)text;

/// 在指定视图上持续显示环形进度条样式的无蒙版 HUD，需手动更新 `progress` 属性，并隐藏 HUD
+ (MBProgressHUD *)lx_showProgressHUDToView:(UIView *)view text:(nullable NSString *)text;

///---------------
/// @name 隐藏 HUD
///---------------

#pragma mark - 隐藏 HUD -

/// 隐藏主窗口上的 HUD
+ (void)lx_hideHUD;

/// 隐藏指定视图上的 HUD
+ (void)lx_hideHUDForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
