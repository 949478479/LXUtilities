//
//  UIStoryboard+LXExtension.m
//
//  Created by 从今以后 on 16/3/5.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UIStoryboard+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIStoryboard (LXExtension)

#pragma mark - 实例化视图控制器 -

+ (UIViewController *)lx_instantiateInitialViewControllerWithStoryboardName:(NSString *)storyboardName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    NSAssert(viewController, @"%@ 故事版中未指定初始视图控制器", storyboardName);
    return viewController;
}

+ (UIInputViewController *)lx_instantiateViewControllerWithIdentifier:(NSString *)identifier inStoryBoard:(NSString *)storyboardName
{
    return [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}

@end

NS_ASSUME_NONNULL_END
