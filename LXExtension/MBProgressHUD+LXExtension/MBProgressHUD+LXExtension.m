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
    NSAssert(keywindow, @"添加MBProgressHUD时主窗口为空");
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

#pragma mark - 持续显示无蒙版的原生活动指示器风格的 HUD -

+ (MBProgressHUD *)lx_showActivityIndicatorWithText:(nullable NSString *)text
{
    UIWindow *keyWindow = [UIWindow lx_keyWindow];
    NSAssert(keyWindow, @"添加MBProgressHUD时主窗口为空");
    return [self lx_showActivityIndicatorWithText:text toView:keyWindow];
}

+ (MBProgressHUD *)lx_showActivityIndicatorWithText:(nullable NSString *)text toView:(UIView *)view
{
    NSParameterAssert(view != nil);

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.labelText = text;
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;

    return hud;
}

#pragma mark - 持续显示有蒙版的原生活动指示器风格的 HUD -

+ (MBProgressHUD *)lx_showDimActivityIndicatorWithText:(nullable NSString *)text
{
    UIWindow *keyWindow = [UIWindow lx_keyWindow];
    NSAssert(keyWindow, @"添加MBProgressHUD时主窗口为空");
    return [self lx_showDimActivityIndicatorWithText:text toView:keyWindow];
}

+ (MBProgressHUD *)lx_showDimActivityIndicatorWithText:(nullable NSString *)text toView:(UIView *)view
{
    NSParameterAssert(view != nil);

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.labelText = text;
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
    NSAssert(image, @"添加MBProgressHUD时图片%@不存在", icon);
    hud.customView = [[UIImageView alloc] initWithImage:image];

    [hud hide:YES afterDelay:1.0];
}

#pragma mark - 持续显示环形进度条 HUD -

+ (MBProgressHUD *)lx_showProgressHUDWithText:(nullable NSString *)text
{
    UIWindow *keyWindow = [UIWindow lx_keyWindow];
    NSAssert(keyWindow, @"添加MBProgressHUD时主窗口为空");
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
    [self lx_hideHUD:YES];
}

+ (void)lx_hideHUD:(BOOL)animated
{
    UIWindow *keyWindow = [UIWindow lx_keyWindow];
    NSAssert(keyWindow, @"隐藏MBProgressHUD时主窗口为空");
    [self hideHUDForView:keyWindow animated:animated];
}

+ (void)lx_hideHUDForView:(UIView *)view
{
    [self lx_hideHUDForView:view animated:YES];
}

+ (void)lx_hideHUDForView:(UIView *)view animated:(BOOL)animated
{
    NSAssert(view, @"隐藏MBProgressHUD时视图为空");
    [self hideHUDForView:view animated:animated];
}

@end

NS_ASSUME_NONNULL_END
