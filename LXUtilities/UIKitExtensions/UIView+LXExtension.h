//
//  UIView+LXExtension.h
//
//  Created by 从今以后 on 15/9/11.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LXExtension)

///--------------------------
/// @name 基于 frame 的布局方法
///--------------------------

#pragma mark - 布局

@property (nonatomic, setter=lx_setSize:) CGSize  lx_size;
@property (nonatomic, setter=lx_setWidth:) CGFloat lx_width;
@property (nonatomic, setter=lx_setHeight:) CGFloat lx_height;

@property (nonatomic, setter=lx_setOrigin:) CGPoint lx_origin;
@property (nonatomic, setter=lx_setOriginX:) CGFloat lx_originX;
@property (nonatomic, setter=lx_setOriginY:) CGFloat lx_originY;

@property (nonatomic, setter=lx_setCenterX:) CGFloat lx_centerX;
@property (nonatomic, setter=lx_setCenterY:) CGFloat lx_centerY;

@property (nonatomic, readonly) CGFloat lx_minX;
@property (nonatomic, readonly) CGFloat lx_minY;
@property (nonatomic, readonly) CGFloat lx_maxX;
@property (nonatomic, readonly) CGFloat lx_maxY;

///-----------
/// @name 图层
///-----------

#pragma mark - 图层

/// 是否光栅化
@property (nonatomic) IBInspectable BOOL shouldRasterize;

/// 图层圆角
@property (nonatomic) IBInspectable CGFloat cornerRadius;
/// 图层边框宽度，单位是像素
@property (nonatomic) IBInspectable CGFloat borderWidth;
/// 图层边框颜色
@property (nonatomic) IBInspectable UIColor *borderColor;

/// 图层阴影偏移
@property (nonatomic) IBInspectable CGSize shadowOffset;
/// 图层阴影透明度
@property (nonatomic) IBInspectable float shadowOpacity;
/// 图层阴影模糊半径
@property (nonatomic) IBInspectable CGFloat shadowRadius;
/// 图层阴影颜色
@property (nonatomic) IBInspectable UIColor *shadowColor;

///----------------
/// @name 视图控制器
///----------------

#pragma mark - 视图控制器

/// 视图或祖先视图所属的 `UIViewController`。
- (nullable __kindof UIViewController *)lx_viewController NS_SWIFT_UNAVAILABLE("Use lx.viewController() instead.");

///--------------
/// @name xib 支持
///--------------

#pragma mark - xib 支持

/// 使用类名同名 `xib` 文件创建 `UINib` 实例。
+ (UINib *)lx_nib;

/// 类名字符串。
+ (NSString *)lx_nibName;

///---------------
/// @name 实例化方法
///---------------

#pragma mark - 实例化方法

/// 使用和类名同名的 `xib` 文件实例化视图。
+ (instancetype)lx_instantiateFromNib NS_SWIFT_UNAVAILABLE("Use lx.instantiateFromNib() instead.");

/// 使用和类名同名的 `xib` 文件实例化视图。
+ (instancetype)lx_instantiateFromNibWithOwner:(nullable id)ownerOrNil
                                       options:(nullable NSDictionary *)optionsOrNil NS_SWIFT_UNAVAILABLE("Use lx.instantiateFromNibWithOwner(_:options:) instead.");
///-----------
/// @name 动画
///-----------

#pragma mark - 动画

/// 暂停/恢复动画。
@property (nonatomic) BOOL lx_paused;

/// 执行水平晃动动画。
- (void)lx_performShakeAnimation;

@end

NS_ASSUME_NONNULL_END
