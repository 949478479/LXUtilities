//
//  UIWindow+LXExtension.m
//
//  Created by 从今以后 on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIWindow+LXExtension.h"
#import "UIApplication+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIWindow (LXExtension)

+ (nullable UIWindow *)lx_keyWindow
{
	return [UIWindow valueForKey:@"keyWindow"] ?: [UIApplication lx_appDelegate].window;
}

+ (nullable UIViewController *)lx_topViewController
{
    UIViewController *topVC = [self lx_keyWindow].rootViewController;

    Class tabBarControllerClass = [UITabBarController class];
    Class navigationControllerClass = [UINavigationController class];

    while (1) {
        if ([topVC isKindOfClass:tabBarControllerClass]) {
            topVC = [(UITabBarController *)topVC selectedViewController];
        } else if ([topVC isKindOfClass:navigationControllerClass]) {
            topVC = [(UINavigationController *)topVC topViewController];
        } else {
            UIViewController *presentedVC = topVC.presentedViewController;
            if (presentedVC) {
                topVC = presentedVC;
            } else {
                return topVC;
            }
        }
    }
}

+ (nullable UIViewController *)lx_rootViewController
{
	return [self lx_keyWindow].rootViewController;
}

+ (void)lx_setRootViewControllerWithStoryboardName:(NSString *)storyboardName
{
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

	UIViewController *rootViewController = [storyboard instantiateInitialViewController];

	[self lx_keyWindow].rootViewController = rootViewController;
}

@end

NS_ASSUME_NONNULL_END
