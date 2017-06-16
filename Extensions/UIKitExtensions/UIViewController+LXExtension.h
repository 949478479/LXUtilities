//
//  UIViewController+LXExtension.h
//
//  Created by 从今以后 on 15/10/13.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LXExtension)

///------------
/// @name 实例化
///------------

#pragma mark - 实例化方法

/// 用控制器类名作为标识符实例化指定故事板中的控制器
+ (__kindof instancetype)lx_instantiateWithStoryboardName:(NSString *)storyboardName;

/// 实例化指定故事板中的指定控制器，若不指定标识符，则使用控制器类名作为标识符
+ (__kindof instancetype)lx_instantiateWithStoryboardName:(NSString *)storyboardName
                                               identifier:(nullable NSString *)identifier;


#pragma mark - 获取各种 bar

///------------------
/// @name 获取各种 bar
///------------------

/// 控制器所属 `UITabBarController` 的 `tabBar`。
@property (nullable, nonatomic, readonly) __kindof UITabBar *lx_tabBar;

/// 控制器所属 `UINavigationController` 的 `toolBar`。
@property (nullable, nonatomic, readonly) __kindof UIToolbar *lx_toolBar;

/// 控制器所属 `UINavigationController` 的 `navigationBar`。
@property (nullable, nonatomic, readonly) __kindof UINavigationBar *lx_navigationBar;


#pragma mark - 获取相关的视图控制器

///------------------------
/// @name 获取相关的视图控制器
///------------------------

/// 获取自身所在的导航控制器栈中的上一个视图控制器。
@property (nullable, nonatomic, readonly) __kindof UIViewController *lx_previousViewController;

/// 获取当前视图控制器层级中的顶层可见视图控制器。
@property (nullable, nonatomic, readonly) __kindof UIViewController *lx_visibleViewControllerIfExist;


#pragma mark - 标题视图

/// 根据标题视图内部约束更新其尺寸
- (void)lx_updateTitleViewSize;

@end

NS_ASSUME_NONNULL_END
