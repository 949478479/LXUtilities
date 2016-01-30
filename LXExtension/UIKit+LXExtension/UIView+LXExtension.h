//
//  UIView+LXExtension.h
//
//  Created by 从今以后 on 15/9/11.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LXExtension)

#pragma mark - 几何布局 -

///--------------------------
/// @name 几何布局（基于 frame）
///--------------------------

///

@property (nonatomic) CGSize  lx_size;
@property (nonatomic) CGFloat lx_width;
@property (nonatomic) CGFloat lx_height;

@property (nonatomic) CGPoint lx_origin;
@property (nonatomic) CGFloat lx_originX;
@property (nonatomic) CGFloat lx_originY;

@property (nonatomic) CGFloat lx_centerX;
@property (nonatomic) CGFloat lx_centerY;

#pragma mark - 图层 -

///-----------
/// @name 图层
///-----------

/// 图层圆角。
@property (nonatomic) IBInspectable CGFloat cornerRadius;
/// 图层边框宽度。
@property (nonatomic) IBInspectable CGFloat borderWidth;
/// 图层边框颜色。
@property (nullable, nonatomic) IBInspectable UIColor *borderColor;

/// 添加图层到附属图层上。
- (void)lx_addSublayer:(CALayer *)layer;

#pragma mark - 视图控制器 -

///----------------
/// @name 视图控制器
///----------------

/// 视图或祖先视图所属的 `UIViewController`。
@property (nullable, nonatomic, readonly) __kindof UIViewController *lx_viewController;
/// 视图或祖先视图所属的 `UITabBarController`。
@property (nullable, nonatomic, readonly) __kindof UITabBarController *lx_tabBarController;
/// 视图或祖先视图所属的 `UISplitViewController`。
@property (nullable, nonatomic, readonly) __kindof UISplitViewController *lx_splitViewController;
/// 视图或祖先视图所属的 `UINavigationController`。
@property (nullable, nonatomic, readonly) __kindof UINavigationController *lx_navigationController;

#pragma mark - UINib -

///----------
/// @name xib
///----------

/// 根据和类名同名的 `xib` 文件创建 `UINib` 对象。
+ (UINib *)lx_nib;

/// 类名字符串。
+ (NSString *)lx_nibName;

/// 使用和类名同名的 `xib` 文件实例化视图。
+ (instancetype)lx_instantiateFromNib NS_SWIFT_UNAVAILABLE("使用 instantiateFromNib() 方法。");

/// 使用和类名同名的 `xib` 文件实例化视图。
+ (instancetype)lx_instantiateFromNibWithOwner:(nullable id)ownerOrNil
                                       options:(nullable NSDictionary *)optionsOrNil NS_SWIFT_UNAVAILABLE("使用 instantiateFromNibWithOwner(_:options:) 方法。");
#pragma mark - 动画 -

///-----------
/// @name 动画
///-----------

/// 暂停、恢复动画。
@property (nonatomic) BOOL lx_paused;

/// 执行水平晃动动画。
- (void)lx_performShakeAnimation;

@end

NS_ASSUME_NONNULL_END
