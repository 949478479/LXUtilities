//
//  UIImage+LXExtension.h
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LXExtension)

///--------------
/// @name 图片缩放
///--------------

/**
 *  缩放图片到目标尺寸.
 *
 *  @param targetSize  目标尺寸。若模式为 @c UIViewContentModeScaleAspectFit，则最终图片不包括未填充区域。
 *  @param contentMode 缩放模式。只支持 @c UIViewContentModeScaleAspectFit 和 @c UIViewContentModeScaleAspectFill。
 */
- (UIImage *)lx_resizedImageWithTargetSize:(CGSize)targetSize
                               contentMode:(UIViewContentMode)contentMode;

/**
 *  返回图片根据 @c UIViewContentModeScaleAspectFit 模式适应 @c boundingRect 的 frame。
 */
- (CGRect)lx_rectForScaleAspectFitInsideBoundingRect:(CGRect)boundingRect;

///--------------
/// @name 图片裁剪
///--------------

/**
 *  生成带边框的圆形图片，图片最终尺寸为裁剪尺寸加上二倍边框宽度。
 *
 *  @param bounds      相对于图片的裁剪区域。
 *  @param borderWidth 边框宽度，传入 @c 0 则无边框。
 *  @param borderColor 边框颜色，传入 @c nil 则为不透明黑色。
 */
- (UIImage *)lx_roundedImageWithBounds:(CGRect)bounds
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(nullable UIColor *)borderColor;

///--------------
/// @name 创建图片
///--------------

/**
 *  使用 @c [UIImage imageNamed:] 创建 @c UIImageRenderingModeAlwaysOriginal 模式的图片。
 */
+ (instancetype)lx_originalRenderingImageNamed:(NSString *)name NS_SWIFT_NAME(init(originalRenderingImageNamed:));

/**
 *  生成纯色图片。若 @c color 的 @c alpha 为 @c 1.0 且 @c cornerRadius 为 @c 0，则图片是完全不透明的。
 *
 *  @param color        图片颜色。
 *  @param size         图片尺寸。
 *  @param cornerRadius 图片圆角。指定为 @c 0 则无圆角。
 */
+ (instancetype)lx_imageWithColor:(UIColor *)color
                             size:(CGSize)size
                     cornerRadius:(CGFloat)cornerRadius NS_SWIFT_NAME(init(color:size:cornerRadius:));

///-----------------
/// @name 获取像素颜色
///-----------------

/**
 *  获取图片指定位置像素的颜色，单位是点。
 */
- (UIColor *)lx_colorAtPosition:(CGPoint)position;

@end

NS_ASSUME_NONNULL_END
