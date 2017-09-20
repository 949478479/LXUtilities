//
//  UIColor+LXExtension.m
//
//  Created by 从今以后 on 15/9/23.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "UIColor+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIColor (LXExtension)

#pragma mark - 颜色信息

+ (UIColor *)lx_colorWithRed:(CGFloat)red
                       green:(CGFloat)green
                        blue:(CGFloat)blue {
    return [self lx_colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)lx_colorWithRed:(CGFloat)red
                       green:(CGFloat)green
                        blue:(CGFloat)blue
                       alpha:(CGFloat)alpha {
    return [self colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)lx_colorWithHexNumber:(uint)num alpha:(CGFloat)alpha {
    NSParameterAssert(num >= 0x000000 && num <= 0xFFFFFF);
    return [self colorWithRed:(CGFloat)((num >> 16) & 0xFF) / 0xFF
                        green:(CGFloat)((num >>  8) & 0xFF) / 0xFF
                         blue:(CGFloat)((num >>  0) & 0xFF) / 0xFF
                        alpha:alpha];
}

+ (UIColor *)lx_colorWithHexNumber:(uint)num {
    return [self lx_colorWithHexNumber:num alpha:1.0];
}

+ (UIColor *)lx_colorWithHexColorString:(NSString *)string alpha:(CGFloat)alpha {
	NSAssert([string rangeOfString:@"^#?[0-9A-Fa-f]{6}$"
						options:NSRegularExpressionSearch].location != NSNotFound,
			 @"颜色字符串格式必须为 #FFFFFF 或 FFFFFF，忽略大小写。");

    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }

	int hex = 0;
	sscanf(string.UTF8String, "%x", &hex);

	return [self lx_colorWithHexNumber:hex alpha:alpha];
}

+ (UIColor *)lx_colorWithHexColorString:(NSString *)string {
    return [self lx_colorWithHexColorString:string alpha:1.0];
}

+ (UIColor *)lx_randomColor {
    return [self lx_randomColorWithAlpha:1.0];
}

+ (UIColor *)lx_randomColorWithAlpha:(CGFloat)alpha {
    return [self colorWithRed:arc4random_uniform(256)/255.0
                        green:arc4random_uniform(256)/255.0
                         blue:arc4random_uniform(256)/255.0
                        alpha:alpha];
}

#pragma mark - 颜色信息

- (CGFloat)lx_alpha {
	return CGColorGetAlpha(self.CGColor);
}

@end

NS_ASSUME_NONNULL_END
