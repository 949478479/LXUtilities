//
//  UIStoryboard+LXExtension.m
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "LXUtilities.h"
#import "UIStoryboard+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIStoryboard (LXExtension)

+ (void)lx_setRootViewControllerWithStoryboardName:(NSString *)storyboardName
{
    UIStoryboard *storyboard = [self storyboardWithName:storyboardName bundle:nil];

    UIViewController *rootViewController = [storyboard instantiateInitialViewController];

    LXKeyWindow().rootViewController = rootViewController;
}

@end

NS_ASSUME_NONNULL_END
