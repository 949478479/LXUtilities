//
//  UIViewController+LXExtension.m
//
//  Created by 从今以后 on 15/10/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIViewController+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIViewController (LXExtension)

+ (instancetype)lx_instantiateFromNib
{
    return [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

- (nullable __kindof UINavigationBar *)lx_navigationBar
{
    return self.navigationController.navigationBar;
}

@end

NS_ASSUME_NONNULL_END
