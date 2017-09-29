//
//  MBProgressHUD+LXExtension.m
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "LXUtilities.h"
#import "LXRingAnimatedView.h"
#import "MBProgressHUD+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MBProgressHUD (LXExtension)

#pragma mark - 短暂显示自定义图标 HUD

+ (MBProgressHUD *)lx_showStatus:(NSString *)status withImage:(UIImage *)image toView:(UIView *)view
{
    NSParameterAssert(view);
    NSParameterAssert(image);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = status;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:image];
    [hud hideAnimated:YES afterDelay:1.0];
    return hud;
}

#pragma mark - 短暂显示纯文本 HUD

+ (MBProgressHUD *)lx_showStatus:(NSString *)status toView:(nullable UIView *)view
{
    NSParameterAssert(status.length > 0);
    MBProgressHUD *hud = [self showHUDAddedTo:view ?: [UIWindow lx_topWindow] animated:YES];
    hud.label.text = status;
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:1.0];
    return hud;
}

#pragma mark - 短暂显示带图标的文本

+ (MBProgressHUD *)lx_showInfoWithStatus:(NSString *)status toView:(nullable UIView *)view {
    return [self lx_showStatus:status withImage:[UIImage imageNamed:@"info"] toView:view ?: [UIWindow lx_topWindow]];
}

+ (MBProgressHUD *)lx_showSuccessWithStatus:(NSString *)status toView:(nullable UIView *)view {
    return [self lx_showStatus:status withImage:[UIImage imageNamed:@"success"] toView:view ?: [UIWindow lx_topWindow]];
}

+ (MBProgressHUD *)lx_showFailureWithStatus:(NSString *)status toView:(nullable UIView *)view {
    return [self lx_showStatus:status withImage:[UIImage imageNamed:@"failure"] toView:view ?: [UIWindow lx_topWindow]];
}

#pragma mark - 持续显示环形动画活动指示器

+ (MBProgressHUD *)lx_showRingActivityIndicatorWithStatus:(nullable NSString *)status toView:(nullable UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?: [UIWindow lx_topWindow] animated:YES];
    hud.label.text = status;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [LXRingAnimatedView new];
    return hud;
}

#pragma mark - 持续显示原生活动指示器

+ (MBProgressHUD *)lx_showActivityIndicatorWithStatus:(nullable NSString *)status toView:(nullable UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?: [UIWindow lx_topWindow] animated:YES];
    hud.label.text = status;
    return hud;
}

#pragma mark - 持续显示伴有遮罩背景的原生活动指示器

+ (MBProgressHUD *)lx_showMaskActivityIndicatorWithStatus:(nullable NSString *)status toView:(nullable UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?: [UIWindow lx_topWindow] animated:YES];
    hud.label.text = status;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:.2f];
    return hud;
}

#pragma mark - 持续显示环形进度条 HUD

+ (MBProgressHUD *)lx_showProgressWithStatus:(nullable NSString *)status toView:(nullable UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view ?: [UIWindow lx_topWindow] animated:YES];
    hud.label.text = status;
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    return hud;
}

#pragma mark - 隐藏 HUD

+ (void)lx_hideHUDForWindow {
    [self lx_hideHUDForWindowAnimated:YES];
}

+ (void)lx_hideHUDForWindowAnimated:(BOOL)animated {
    [self hideHUDForView:[UIWindow lx_topWindow] animated:animated];
}

- (void)lx_hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    NSTimer *timer = [self valueForKey:@"hideDelayTimer"];
    if (timer) {
        [timer invalidate];
    }
    [self hideAnimated:animated afterDelay:delay];
}

@end

NS_ASSUME_NONNULL_END
