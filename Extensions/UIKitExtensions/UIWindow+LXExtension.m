//
//  UIWindow+LXExtension.m
//
//  Created by 从今以后 on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIWindow+LXExtension.h"
#import "UIApplication+LXExtension.h"
#import "UIViewController+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIWindow (LXExtension)

+ (nullable UIWindow *)lx_keyWindow {
	return [UIWindow valueForKey:@"keyWindow"] ?: [UIApplication lx_appDelegate].window;
}

+ (nullable UIWindow *)lx_topWindow {
    return [UIApplication sharedApplication].windows.lastObject;
}

+ (nullable UIViewController *)lx_topViewController {
    return [[self lx_keyWindow].rootViewController lx_visibleViewControllerIfExist];
}

+ (nullable UIViewController *)lx_rootViewController {
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
