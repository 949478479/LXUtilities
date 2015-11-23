//
//  UIView+LXExtension.h
//
//  Created by 从今以后 on 15/9/11.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LXExtension)

#pragma mark - Bounds|Frame -

///-------------------
/// @name Bounds|Frame
///-------------------

@property (nonatomic) CGSize  lx_size;
@property (nonatomic) CGFloat lx_width;
@property (nonatomic) CGFloat lx_height;

@property (nonatomic) CGPoint lx_origin;
@property (nonatomic) CGFloat lx_originX;
@property (nonatomic) CGFloat lx_originY;

@property (nonatomic) CGFloat lx_centerX;
@property (nonatomic) CGFloat lx_centerY;

#pragma mark - CALyer -

///-------------
/// @name CALyer
///-------------

/**
 *  @c layer.cornerRadius
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
/**
 *  @c layer.borderWidth
 */
@property (nonatomic) IBInspectable CGFloat borderWidth;
/**
 *  @c layer.borderColor
 */
@property (nullable, nonatomic) IBInspectable UIColor *borderColor;

/**
 *  为 @c layer 添加子图层。
 *
 *  @param layer 要添加的子图层。
 */
- (void)lx_addSublayer:(CALayer *)layer;

#pragma mark - UIViewController -

///-----------------------
/// @name UIViewController
///-----------------------

/**
 *  获取视图所属的视图控制器，即响应链上最近的 @c UIViewController。
 */
@property (nullable, nonatomic, readonly) __kindof UIViewController *lx_viewController;
/**
 *  获取视图所属的导航控制器，即响应链上最近的 @c UINavigationController。
 */
@property (nullable, nonatomic, readonly) __kindof UITabBarController *lx_tabBarController;
/**
 *  获取视图所属的选项卡控制器，即响应链上最近的 @c UITabBarController。
 */
@property (nullable, nonatomic, readonly) __kindof UINavigationController *lx_navigationController;

#pragma mark - UINib -

///------------
/// @name UINib
///------------

/**
 *  根据和类名同名的 xib 文件创建 @c UINib 对象。
 */
+ (UINib *)lx_nib;

/**
 *  返回 xib 文件名，即类名。
 */
+ (NSString *)lx_nibName;

/**
 *  使用和类名同名的 xib 文件实例化视图。
 */
+ (instancetype)lx_instantiateFromNib NS_SWIFT_UNAVAILABLE("使用 instantiateFromNib() 方法。");

/**
 *  使用和类名同名的 xib 文件实例化视图。
 */
+ (instancetype)lx_instantiateFromNibWithOwner:(nullable id)ownerOrNil
                                       options:(nullable NSDictionary *)optionsOrNil NS_SWIFT_UNAVAILABLE("使用 instantiateFromNibWithOwner(_:options:) 方法。");

#pragma mark - 动画 -

///-----------
/// @name 动画
///-----------

/**
 *  执行晃动动画。
 */
- (void)lx_performShakeAnimation;

@end

NS_ASSUME_NONNULL_END
