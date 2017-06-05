//
//  MBProgressHUD+LXExtension.h
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (LXExtension)

/// 在视图上短暂显示文本并可附带自定义图标
+ (MBProgressHUD *)lx_showStatus:(NSString *)status withImage:(UIImage *)image toView:(UIView *)view;

/// 在视图上显示纯文本并自动移除，若 view 传 nil 则在主窗口显示
+ (MBProgressHUD *)lx_showStatus:(NSString *)status toView:(nullable UIView *)view;

/// 在视图上短暂显示带感叹号图标的文本并自动移除，若 view 传 nil 则在主窗口显示
+ (MBProgressHUD *)lx_showInfoWithStatus:(NSString *)status toView:(nullable UIView *)view;

/// 在指定视图上持续显示环形动画活动指示器，若 view 传 nil 则在主窗口显示，需要手动移除
+ (MBProgressHUD *)lx_showRingActivityIndicatorWithStatus:(nullable NSString *)status toView:(nullable UIView *)view;

/// 在指定视图上持续显示原生活动指示器，若 view 传 nil 则在主窗口显示，需要手动移除
+ (MBProgressHUD *)lx_showActivityIndicatorWithStatus:(nullable NSString *)status toView:(nullable UIView *)view;

/// 在视图上持续显示伴有背景遮罩的原生活动指示器，若 view 传 nil 则在主窗口显示，需要手动移除
+ (MBProgressHUD *)lx_showMaskActivityIndicatorWithStatus:(nullable NSString *)status toView:(nullable UIView *)view;

/// 在视图上持续显示环形进度条，若 view 传 nil 则在主窗口显示，需要手动移除
+ (MBProgressHUD *)lx_showProgressWithStatus:(nullable NSString *)status toView:(nullable UIView *)view;

/// 隐藏窗口上的 HUD，有动画效果
+ (void)lx_hideHUDForWindow;
/// 隐藏窗口上的 HUD
+ (void)lx_hideHUDForWindowAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
