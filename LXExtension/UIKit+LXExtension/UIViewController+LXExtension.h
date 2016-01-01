//
//  UIViewController+LXExtension.h
//
//  Created by 从今以后 on 15/10/13.
//  Copyright © 2015年 apple. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LXExtension)

///--------------
/// @name 便捷属性
///--------------

/**
 *  获取控制器的选项卡。
 */
@property (nullable, nonatomic, readonly) UITabBar *lx_tabBar;

/**
 *  获取控制器的导航栏。
 */
@property (nullable, nonatomic, readonly) UINavigationBar *lx_navigationBar;

///---------------
/// @name 实例化方法
///---------------

/**
 *  使用和类名同名的 @c xib 文件实例化控制器。
 */
+ (instancetype)lx_instantiateFromNib;

/**
 *  实例化指定故事板中的初始控制器。
 */
+ (instancetype)lx_instantiateWithStoryboardName:(NSString *)storyboardName;

/**
 *  实例化指定故事板中的指定控制器。
 */
+ (instancetype)lx_instantiateWithStoryboardName:(NSString *)storyboardName
                                      identifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
