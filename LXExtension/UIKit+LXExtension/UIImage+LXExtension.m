//
//  UIImage+LXExtension.m
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import AVFoundation.AVUtilities;
#import "UIImage+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIImage (LXExtension)

#pragma mark - 图片缩放 -

- (UIImage *)lx_resizedImageWithTargetSize:(CGSize)targetSize
                               contentMode:(UIViewContentMode)contentMode
{
    CGRect drawingRect = { .size = targetSize }; // 默认为 UIViewContentModeScaleToFill

    if (contentMode == UIViewContentModeScaleAspectFit)
    {
        CGRect boundingRect = { .size = targetSize };
        targetSize  = [self lx_rectForScaleAspectFitInsideBoundingRect:boundingRect].size;
        drawingRect = CGRectMake(0, 0, targetSize.width, targetSize.height);
    }
    else if (contentMode == UIViewContentModeScaleAspectFill)
    {
        CGFloat radio = self.size.height / self.size.width;

        // 先优先满足宽度,根据纵横比算出高度.
        drawingRect = CGRectMake(0, 0, targetSize.width, targetSize.width * radio);

        if (drawingRect.size.height < targetSize.height) // 若高度不足期望值,说明应优先满足高度.
        {
            // 优先满足高度,根据纵横比计算宽度.
            drawingRect.size = CGSizeMake(targetSize.height / radio, targetSize.height);
            // 绘制区域的原点 x 坐标需向左平移,从而使裁剪区域居中.
            drawingRect.origin.x = -(drawingRect.size.width - targetSize.width) / 2;
        }
        else
        {
            // 在宽度满足期望值的情况下,高度大于等于期望高度.绘制区域原点 y 坐标应向上平移,从而使裁剪区域居中.
            drawingRect.origin.y = -(drawingRect.size.height - targetSize.height) / 2;
        }
    }

    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0);

    [self drawInRect:drawingRect];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return image;
}

- (CGRect)lx_rectForScaleAspectFitInsideBoundingRect:(CGRect)boundingRect
{
    return AVMakeRectWithAspectRatioInsideRect(self.size, boundingRect);
}

#pragma mark - 图片裁剪 -

- (UIImage *)lx_roundedImageWithBounds:(CGRect)bounds
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(nullable UIColor *)borderColor
{
    // 上下文尺寸需算上 borderWidth
    CGSize contextSize = { bounds.size.width + 2 * borderWidth, bounds.size.height + 2 * borderWidth };

    UIGraphicsBeginImageContextWithOptions(contextSize, NO, 0);

    if (borderWidth > 0)
    {
        CGRect outerBoundaryRect = { .size = contextSize }; // 外边框区域即上下文区域.

        UIBezierPath *outerBoundary = [UIBezierPath bezierPathWithOvalInRect:outerBoundaryRect];

        [borderColor setFill];
        [outerBoundary fill];
    }

    // 内边框原点需在上下文原点基础上向内调整 borderWidth. 尺寸即为图片裁剪尺寸.
    CGRect innerBoundaryRect = { .origin = { borderWidth, borderWidth }, .size = bounds.size };

    UIBezierPath *innerBoundary = [UIBezierPath bezierPathWithOvalInRect:innerBoundaryRect];

    [innerBoundary addClip];

    // 若裁剪区域原点不在图片左上角,需在内边框原点基础上进行调整,从而使裁剪区域左上角位于内边框原点.
    CGPoint drawingPoint = { borderWidth - bounds.origin.x, borderWidth - bounds.origin.y };

    [self drawAtPoint:drawingPoint];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 图片渲染 -

+ (instancetype)lx_originalRenderingImageNamed:(NSString *)name
{
    return [[self imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)lx_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius
{
    NSParameterAssert(color != nil);

    CGColorRef cg_color = color.CGColor;

    CGFloat alpha = CGColorGetAlpha(cg_color);

    BOOL opaque = (alpha == 1.0 && cornerRadius == 0.0);

    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);

    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), cg_color);

    [[UIBezierPath bezierPathWithRoundedRect:(CGRect){.size = size} cornerRadius:cornerRadius] fill];

    return UIGraphicsGetImageFromCurrentImageContext();
}

#pragma mark - 获取像素颜色 -

- (UIColor *)lx_colorAtPosition:(CGPoint)position
{
    size_t pixelsWide = 1;
    size_t pixelsHigh = 1;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = pixelsWide * 4;
    size_t bitmapByteCount = bytesPerRow * pixelsHigh;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *bitmapData  = calloc(bitmapByteCount, sizeof(unsigned char));
    CGBitmapInfo bitmapInfo    = (CGBitmapInfo)kCGImageAlphaPremultipliedLast;

    CGContextRef bitmapContext = CGBitmapContextCreate(bitmapData,
                                                       pixelsWide,
                                                       pixelsHigh,
                                                       bitsPerComponent,
                                                       bytesPerRow,
                                                       colorSpace,
                                                       bitmapInfo);

    CGRect rect = CGRectMake(position.x * self.scale, position.y * self.scale, pixelsWide, pixelsHigh);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);

    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, pixelsWide, pixelsHigh), imageRef);

    CGFloat alpha = bitmapData[3] / 255.0;
    CGFloat red   = bitmapData[0] / 255.0 / alpha;
    CGFloat green = bitmapData[1] / 255.0 / alpha;
    CGFloat blue  = bitmapData[2] / 255.0 / alpha;

//    NSLog(@"%d %d %d %d", bitmapData[0], bitmapData[1], bitmapData[2], bitmapData[3]);
//    NSLog(@"%f %f %f %f", red, green, blue, alpha);

    free(bitmapData);
    CGImageRelease(imageRef);
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

NS_ASSUME_NONNULL_END
