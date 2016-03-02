//
//  MBProgressHUD+LXExtension.m
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "LXUtilities.h"
#import "MBProgressHUD+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MBProgressHUD (LXExtension)

#pragma mark - 短暂显示纯文本 HUD -

+ (MBProgressHUD *)lx_showTextHUDWithText:(NSString *)text
{
    UIWindow *keywindow = [UIWindow lx_keyWindow];
    NSAssert(keywindow, @"主窗口为空");
    return [self lx_showTextHUDWithText:text toView:keywindow];
}

+ (MBProgressHUD *)lx_showTextHUDWithText:(NSString *)text toView:(UIView *)view
{
    NSParameterAssert(text.length > 0);
    NSParameterAssert(view != nil);

    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];

    hud.labelText = text;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;

    [hud hide:YES afterDelay:1.0];

    return hud;
}

#pragma mark - 持续显示带蒙版的原生活动指示器风格的 HUD -

+ (MBProgressHUD *)lx_showActivityIndicatorWithMessage:(nullable NSString *)message
{
    UIWindow *keyWindow = [UIWindow lx_keyWindow];
    NSAssert(keyWindow, @"主窗口为空");
    return [self lx_showActivityIndicatorWithMessage:message toView:keyWindow];
}

+ (MBProgressHUD *)lx_showActivityIndicatorWithMessage:(nullable NSString *)message toView:(UIView *)view
{
    NSParameterAssert(view != nil);

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.labelText = message;
    hud.dimBackground = YES;
    hud.removeFromSuperViewOnHide = YES;

    return hud;
}

#pragma mark - 短暂显示自定义图标 HUD -

+ (void)lx_show:(nullable NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    NSParameterAssert(view != nil);

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;

    UIImage *image = [UIImage imageNamed:icon];
    NSAssert(image, @"图片 %@ 不存在", icon);
    hud.customView = [[UIImageView alloc] initWithImage:image];

    [hud hide:YES afterDelay:1.0];
}

#pragma mark - 持续显示环形进度条 HUD -

+ (MBProgressHUD *)lx_showProgressHUDWithText:(nullable NSString *)text
{
    UIWindow *keyWindow = [UIWindow lx_keyWindow];
    NSAssert(keyWindow, @"主窗口为空");
    return [self lx_showProgressHUDToView:keyWindow text:text];
}

+ (MBProgressHUD *)lx_showProgressHUDToView:(UIView *)view text:(nullable NSString *)text
{
    NSParameterAssert(view != nil);

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeAnnularDeterminate;

    return hud;
}

#pragma mark - 隐藏 HUD -

+ (void)lx_hideHUD
{
    UIWindow *keyWindow = [UIWindow lx_keyWindow];
    NSAssert(keyWindow, @"主窗口为空");
    [self hideHUDForView:keyWindow animated:YES];
}

+ (void)lx_hideHUDForView:(UIView *)view
{
    NSParameterAssert(view != nil);
    [self hideHUDForView:view animated:YES];
}

@end

NS_ASSUME_NONNULL_END
