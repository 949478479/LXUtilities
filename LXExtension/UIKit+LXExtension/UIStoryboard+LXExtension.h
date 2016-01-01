//
//  UIStoryboard+LXExtension.h
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIStoryboard (LXExtension)

/**
 *  将指定故事板中的初始控制器设置为主窗口的根控制器。
 */
+ (void)lx_setRootViewControllerWithStoryboardName:(NSString *)storyboardName;

@end

NS_ASSUME_NONNULL_END
