//
//  UIImage+LXExtension.h
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LXExtension)

/// 图片纵横比例
- (CGFloat)lx_aspectRatio;

///--------------
/// @name 图片创建
///--------------

#pragma mark - 图片创建

/**
 *  使用 @c +[UIImage imageWithContentsOfFile:] 创建图片
 *
 *  @param path 图片相对于 mainBundle 的路径，需包含扩展名
 */
+ (nullable instancetype)lx_imageWithContentsOfFile:(NSString *)path NS_SWIFT_NAME(init(contentsOfFile:));

/// 使用 @c +[UIImage imageNamed:] 创建 @c UIImageRenderingModeAlwaysOriginal 渲染模式的图片
+ (nullable instancetype)lx_originalRenderingImageNamed:(NSString *)name NS_SWIFT_NAME(init(originalRenderingImageNamed:));

/// 生成尺寸为 1pt * 1pt 的纯色图片
+ (nullable instancetype)lx_imageWithColor:(UIColor *)color NS_SWIFT_NAME(init(color:));

/**
 生成指定大小的纯色图片

 @param color	     图片颜色
 @param size		 图片大小，单位是 pt
 @param cornerRadius 图片圆角半径
 */
+ (nullable instancetype)lx_imageWithColor:(UIColor *)color
									  size:(CGSize)size
							  cornerRadius:(CGFloat)cornerRadius NS_SWIFT_NAME(init(color:size:cornerRadius:));

/**
 将文字渲染为图片，图片尺寸和文字尺寸相同

 @param attributedString 文字内容
 @param backgroundColor  背景色，默认透明
 */
+ (nullable instancetype)lx_imageWithAttributedString:(NSAttributedString *)attributedString
									  backgroundColor:(UIColor *)backgroundColor NS_SWIFT_NAME(init(AttributedString:backgroundColor:));


/**
 对指定视图的可见视图层级截图

 @param view         要截图的视图
 @param afterUpdates 是否要在界面更新完成后才截图
 */
+ (nullable instancetype)lx_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterUpdates NS_SWIFT_NAME(init(view:afterScreenUpdates:));

///--------------
/// @name 图片缩放
///--------------

#pragma mark - 图片缩放

/**
 缩放图片到指定大小，以 pt 为单位

 @param size	    新图片大小，以 pt 为单位，除非使用 UIViewContentModeScaleToFill，否则缩放后的实际大小可能会小于指定大小
 @param contentMode 默认为 @c UIViewContentModeScaleAspectFit，
					其他可选项有 @c UIViewContentModeScaleToFill 和 @c UIViewContentModeScaleAspectFill
 */
- (UIImage *)lx_imageByScalingToSize:(CGSize)size
						 contentMode:(UIViewContentMode)contentMode;

/// 图片在 UIViewContentModeScaleAspectFit 模式下填充 boundingRect 时的 frame
- (CGRect)lx_rectWithAspectRatioInsideRect:(CGRect)boundingRect;

///--------------
/// @name 图片裁剪
///--------------

#pragma mark - 图片裁剪

/**
 裁剪图片指定区域作为新图片

 @param rect 裁剪区域，以 pt 为单位
 */
- (UIImage *)lx_imageWithClippedRect:(CGRect)rect;

/**
 生成有圆角的背景透明图片

 @param cornerRadius 圆角半径，以 pt 为单位
 */
- (UIImage *)lx_imageWithCornerRadius:(CGFloat)cornerRadius;

/**
 生成有圆角和背景色的图片

 @param cornerRadius    圆角半径，以 pt 为单位
 @param backgroundColor 背景颜色，默认透明
 */
- (UIImage *)lx_imageWithCornerRadius:(CGFloat)cornerRadius
					  backgroundColor:(nullable UIColor *)backgroundColor;

///--------------
/// @name 图片效果
///--------------

#pragma mark - 图片效果

/// 将图片转换为灰度图片
- (UIImage *)lx_grayImage;

/// 设置图片透明度
- (UIImage *)lx_imageWithAlpha:(CGFloat)alpha;

/// 使用指定颜色重新渲染图片
- (UIImage *)lx_imageWithTintColor:(UIColor *)tintColor;

///--------------
/// @name 图片颜色
///--------------

#pragma mark - 图片信息

/// 判断一张图是否不存在 alpha 通道，注意 “不存在 alpha 通道” 不等价于 “不透明”。一张不透明的图有可能是存在 alpha 通道但 alpha 值为 1。
- (BOOL)lx_opaque;

/// 获取当前图片的均色，原理是将图片绘制到 1px * 1px 的矩形内，再从当前区域取色，得到图片的均色
- (UIColor *)lx_averageColor;

/// 获取图片指定位置像素的颜色，单位是 px
- (UIColor *)lx_pixelColorAtPosition:(CGPoint)position;

///-------------
/// @name 二维码
///-------------

#pragma mark - 二维码

/**
 *  生成二维码图片
 *
 *  @param message     二维码内容
 *  @param size        二维码尺寸，以 pt 为单位
 *  @param logo        二维码中心图案
 *  @param logoSize    二维码中心图案尺寸，以 pt 为单位
 *  @param transparent 是否将白色背景变为透明
 */
+ (instancetype)lx_QRCodeImageWithMessage:(NSString *)message
                                     size:(CGSize)size
                                     logo:(nullable UIImage *)logo
								 logoSize:(CGSize)logoSize
                              transparent:(BOOL)transparent;
@end

NS_ASSUME_NONNULL_END
