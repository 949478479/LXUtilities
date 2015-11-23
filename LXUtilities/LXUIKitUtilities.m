//
//  LXUIKitUtilities.m
//
//  Created by 从今以后 on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LXUIKitUtilities.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 设备信息

BOOL LXDeviceIsPad()
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

#pragma mark - AppDelegate

AppDelegate * LXAppDelegate()
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark - 屏幕

CGSize LXScreenSize()
{
    return [UIScreen mainScreen].bounds.size;
}

CGFloat LXScreenScale()
{
    return [UIScreen mainScreen].scale;
}

#pragma mark - 窗口

UIWindow * LXKeyWindow()
{
    UIApplication *application = [UIApplication sharedApplication];
    id<UIApplicationDelegate> appDelegate = application.delegate;
    return application.keyWindow ?: appDelegate.window;
}

UIWindow * LXTopWindow()
{
    UIApplication *application = [UIApplication sharedApplication];
    id<UIApplicationDelegate> appDelegate = application.delegate;
    return application.windows.lastObject ?: appDelegate.window;
}

#pragma mark - 控制器

UIViewController * LXTopViewController()
{
    UIViewController *rootVC = LXKeyWindow().rootViewController;
    UIViewController *topVC  = rootVC.presentedViewController;

    return topVC ?: rootVC;
}

UIViewController * LXRootViewController()
{
    return LXKeyWindow().rootViewController;
}

NS_ASSUME_NONNULL_END
