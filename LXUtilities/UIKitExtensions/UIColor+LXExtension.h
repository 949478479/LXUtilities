//
//  UIColor+LXExtension.h
//
//  Created by 从今以后 on 15/9/23.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LXExtension)

///--------------
/// @name 颜色创建
///--------------

#pragma mark - 颜色创建

/**
 *  创建 @c alpha 为 1.0 的 RGB 颜色，颜色值范围 0.0~255.0。
 */
+ (UIColor *)lx_colorWithRed:(CGFloat)red
                       green:(CGFloat)green
                        blue:(CGFloat)blue NS_SWIFT_NAME(init(red:green:blue:));

/**
 *  创建指定 @c alpha 的 RGB 颜色，颜色值范围 0.0~255.0。
 */
+ (UIColor *)lx_colorWithRed:(CGFloat)red
                       green:(CGFloat)green
                        blue:(CGFloat)blue
                       alpha:(CGFloat)alpha NS_SWIFT_NAME(init(red:green:blue:_alpha:));

/**
 *  根据十六进制颜色值创建 @c alpha 为 @c 1.0 的颜色。例如，传入 @c 0xFFFFFF 将创建白色。
 */
+ (UIColor *)lx_colorWithHexNumber:(uint)number NS_SWIFT_NAME(init(hexNumber:));

/**
 *  根据十六进制颜色值和指定 @c alpha 创建颜色。例如，传入 @c 0xFFFFFF 将创建白色。
 */
+ (UIColor *)lx_colorWithHexNumber:(uint)number alpha:(CGFloat)alpha NS_SWIFT_NAME(init(hexNumber:alpha:));

/**
 *  根据十六进制颜色值字符串创建 @c alpha 为 @c 1.0 的颜色。例如，传入 @c @"#FFFFFF" 或 @c @"FFFFFF" 将创建白色。
 */
+ (UIColor *)lx_colorWithHexColorString:(NSString *)string NS_SWIFT_NAME(init(hexColorString:));

/**
 *  根据十六进制颜色值字符串和指定 @c alpha 创建颜色。例如，传入 @c @"#FFFFFF" 或 @c @"FFFFFF" 将创建白色。
 */
+ (UIColor *)lx_colorWithHexColorString:(NSString *)string alpha:(CGFloat)alpha NS_SWIFT_NAME(init(hexColorString:alpha:));

/**
 *  生成 @c alpha 为 @c 1.0 的随机色。
 */
+ (UIColor *)lx_randomColor;

/**
 *  生成指定 @c alpha 的随机色。
 */
+ (UIColor *)lx_randomColorWithAlpha:(CGFloat)alpha;

///--------------
/// @name 颜色信息
///--------------

#pragma mark - 颜色信息

- (CGFloat)lx_alpha;

@end

NS_ASSUME_NONNULL_END
