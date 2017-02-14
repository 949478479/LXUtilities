//
//  UIViewController+LXExtension.m
//
//  Created by 从今以后 on 15/10/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIViewController+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIViewController (LXExtension)

#pragma mark - 实例化方法 -

+ (instancetype)lx_instantiateWithStoryboardName:(NSString *)storyboardName
{
    return [self lx_instantiateWithStoryboardName:storyboardName identifier:nil];
}

+ (instancetype)lx_instantiateWithStoryboardName:(NSString *)storyboardName
                                      identifier:(nullable NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

    if (identifier) {
        return [storyboard instantiateViewControllerWithIdentifier:identifier];
    }

    identifier = NSStringFromClass(self);
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    NSAssert(viewController, @"%@ 故事版中的 %@ 视图控制器未指定标识符", storyboardName, identifier);
    return viewController;
}

#pragma mark - 查询方法

- (nullable UITabBar *)lx_tabBar
{
	return self.tabBarController.tabBar;
}

- (nullable UIToolbar *)lx_toolBar
{
	return self.navigationController.toolbar;
}

- (nullable UINavigationBar *)lx_navigationBar
{
	return self.navigationController.navigationBar;
}

- (nullable UIViewController *)lx_visibleViewControllerIfExist
{
	if (self.presentedViewController) {
		return [self.presentedViewController lx_visibleViewControllerIfExist];
	}

	if ([self isKindOfClass:[UINavigationController class]]) {
		return [((UINavigationController *)self).topViewController lx_visibleViewControllerIfExist];
	}

	if ([self isKindOfClass:[UITabBarController class]]) {
		return [((UITabBarController *)self).selectedViewController lx_visibleViewControllerIfExist];
	}

	if (self.isViewLoaded && self.view.window) {
		return self;
	} else {
		NSLog(@"lx_visibleViewControllerIfExist:，找不到可见的视图控制器。self = %@", self);
		return nil;
	}
}

- (nullable UIViewController *)lx_previousViewController
{
	NSArray *viewControllers = self.navigationController.viewControllers;

	NSUInteger countOfViewControllers = viewControllers.count;
	if (countOfViewControllers < 2) {
		return nil;
	}

	NSUInteger indexOfSelf = [viewControllers indexOfObjectIdenticalTo:self];
	if (indexOfSelf == NSNotFound || indexOfSelf == 0) {
		return nil;
	}

	return viewControllers[indexOfSelf - 1];
}

@end

NS_ASSUME_NONNULL_END
