//
//  UIImage+LXExtension.m
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import AVFoundation.AVUtilities;
#import "UIImage+LXExtension.h"
#import "LXUIUtilities.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIImage (LXExtension)

- (CGFloat)lx_aspectRatio {
	return self.size.height / self.size.width;
}

#pragma mark - 图片创建

+ (nullable instancetype)lx_imageWithContentsOfFile:(NSString *)path
{
	return [self imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
}

+ (nullable instancetype)lx_originalRenderingImageNamed:(NSString *)name
{
	return [[self imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (nullable instancetype)lx_imageWithColor:(UIColor *)color
{
	return [self lx_imageWithColor:color size:CGSizeMake(1.0, 1.0) cornerRadius:0.0];
}

+ (nullable instancetype)lx_imageWithColor:(UIColor *)color
									  size:(CGSize)size
							  cornerRadius:(CGFloat)cornerRadius
{
	color = color ?: [UIColor clearColor];
	size = LXSizeCeilInPixel(size, [[UIScreen mainScreen] scale]);
	BOOL opaque = (cornerRadius == 0.0 && CGColorGetAlpha(color.CGColor) == 1.0);
	UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
	[color setFill];
	[[UIBezierPath bezierPathWithRoundedRect:LXRectMakeWithSize(size) cornerRadius:cornerRadius] fill];
	UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return finalImage;
}

+ (nullable instancetype)lx_imageWithAttributedString:(NSAttributedString *)attributedString
									  backgroundColor:(UIColor *)backgroundColor
{
	BOOL opaque = (backgroundColor != nil) && (CGColorGetAlpha(backgroundColor.CGColor) == 1.0);
	CGSize stringSize = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
	stringSize = LXSizeCeil(stringSize);
	CGRect drawingRect = LXRectMakeWithSize(stringSize);
	UIGraphicsBeginImageContextWithOptions(stringSize, opaque, 0);
	if (backgroundColor) {
		[backgroundColor setFill];
		UIRectFill(drawingRect);
	}
	[attributedString drawInRect:drawingRect];
	UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return finalImage;
}

+ (nullable instancetype)lx_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterUpdates
{
	BOOL opaque = (view.alpha == 1.0);
	UIGraphicsBeginImageContextWithOptions(view.bounds.size, opaque, 0);
	[view drawViewHierarchyInRect:LXRectMakeWithSize(view.bounds.size) afterScreenUpdates:afterUpdates];
	UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return finalImage;
}

#pragma mark - 图片缩放

- (UIImage *)lx_imageByScalingToSize:(CGSize)size
						 contentMode:(UIViewContentMode)contentMode
{
	size = LXSizeCeilInPixel(size, self.scale);

	CGRect drawingRect = CGRectZero;
	if (contentMode == UIViewContentModeScaleToFill) {
		drawingRect = LXRectMakeWithSize(size);
	} else {
		CGFloat ratio = 0;
		CGSize imageSize = self.size;
		CGFloat horizontalRatio = size.width / imageSize.width;
		CGFloat verticalRatio = size.height / imageSize.height;
		if (contentMode == UIViewContentModeScaleAspectFill) {
			ratio = fmaxf(horizontalRatio, verticalRatio);
		} else {
			// 默认为 UIViewContentModeScaleAspectFit
			ratio = fminf(horizontalRatio, verticalRatio);
		}
		drawingRect.size.width = imageSize.width * ratio;
		drawingRect.size.height = imageSize.height * ratio;
		drawingRect.origin.x = (size.width - drawingRect.size.width) / 2;
		drawingRect.origin.y = (size.height - drawingRect.size.height) / 2;
		drawingRect = LXRectFlatted(drawingRect, self.scale);
	}

	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
	BOOL opaque = (alphaInfo == kCGImageAlphaNoneSkipLast) ||
	(alphaInfo == kCGImageAlphaNoneSkipFirst) ||
	(alphaInfo == kCGImageAlphaNone);
	opaque = (opaque && CGRectContainsRect(drawingRect, LXRectMakeWithSize(size)));

	UIGraphicsBeginImageContextWithOptions(size, opaque, self.scale);
    [self drawInRect:drawingRect];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

- (CGRect)lx_rectWithAspectRatioInsideRect:(CGRect)boundingRect {
    return LXRectFlatted(AVMakeRectWithAspectRatioInsideRect(self.size, boundingRect), [[UIScreen mainScreen] scale]);
}

#pragma mark - 图片裁剪

- (UIImage *)lx_imageWithClippedRect:(CGRect)rect
{
	CGRect clippedRect = CGRectIntegral(LXRectApplyScale(rect, self.scale));
	CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, clippedRect);
	UIImage *finalImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
	CGImageRelease(imageRef);
	return finalImage;
}

- (UIImage *)lx_imageWithCornerRadius:(CGFloat)cornerRadius {
	return [self lx_imageWithCornerRadius:cornerRadius backgroundColor:nil];
}

- (UIImage *)lx_imageWithCornerRadius:(CGFloat)cornerRadius
					  backgroundColor:(nullable UIColor *)backgroundColor
{
	BOOL opaque = (backgroundColor != nil) && (CGColorGetAlpha(backgroundColor.CGColor) == 1.0);
	UIGraphicsBeginImageContextWithOptions(self.size, opaque, self.scale);
	CGRect drawingRect = LXRectMakeWithSize(self.size);
	if (backgroundColor) {
		[backgroundColor setFill];
		UIRectFill(drawingRect);
	}
	[[UIBezierPath bezierPathWithRoundedRect:drawingRect cornerRadius:cornerRadius] addClip];
	[self drawAtPoint:CGPointZero];
	UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return finalImage;
}

#pragma mark - 图片效果

- (UIImage *)lx_grayImage
{
	size_t width = self.size.width * self.scale;
	size_t height = self.size.height * self.scale;

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
	CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
	CGColorSpaceRelease(colorSpace);
	CGContextRelease(context);

	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
	BOOL opaque = (alphaInfo == kCGImageAlphaNoneSkipLast) ||
	(alphaInfo == kCGImageAlphaNoneSkipFirst) ||
	(alphaInfo == kCGImageAlphaNone);

	if (opaque) {
		UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef scale:self.scale orientation:self.imageOrientation];
		CGImageRelease(grayImageRef);
		return grayImage;
	}

	context = CGBitmapContextCreate(NULL, width, height, 8, 0, NULL, kCGImageAlphaOnly);
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
	CGImageRef maskImageRef = CGBitmapContextCreateImage(context);
	CGImageRef maskedGrayImageRef = CGImageCreateWithMask(grayImageRef, maskImageRef);
	CGContextRelease(context);
	CGImageRelease(grayImageRef);
	CGImageRelease(maskImageRef);

	UIImage *maskedGrayImage = [UIImage imageWithCGImage:maskedGrayImageRef scale:self.scale orientation:self.imageOrientation];
	CGImageRelease(maskedGrayImageRef);
	return maskedGrayImage;
}

- (UIImage *)lx_imageWithAlpha:(CGFloat)alpha
{
	UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
	[self drawInRect:LXRectMakeWithSize(self.size) blendMode:kCGBlendModeNormal alpha:alpha];
	UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return finalImage;
}

- (UIImage *)lx_imageWithTintColor:(UIColor *)tintColor
{
	UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, 0, self.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGRect rect = LXRectMakeWithSize(self.size);
	CGContextClipToMask(context, rect, self.CGImage);
	CGContextSetFillColorWithColor(context, tintColor.CGColor);
	CGContextFillRect(context, rect);
	UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return finalImage;
}

#pragma mark - 获取像素颜色

- (UIColor *)lx_averageColor
{
	unsigned char rgba[4] = {};
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
	CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
	CGColorSpaceRelease(colorSpace);
	CGContextRelease(context);
	if (rgba[3] > 0) {
		return [UIColor colorWithRed:(CGFloat)rgba[0] / rgba[3]
							   green:(CGFloat)rgba[1] / rgba[3]
								blue:(CGFloat)rgba[2] / rgba[3]
							   alpha:(CGFloat)rgba[3] / 255.0];
	} else {
		return [UIColor colorWithRed:rgba[0]/255.0
							   green:rgba[1]/255.0
								blue:rgba[2]/255.0
							   alpha:0];
	}
}

- (UIColor *)lx_pixelColorAtPosition:(CGPoint)position
{
	position = LXPointRound(position);

	unsigned char rgba[4] = {};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(position.x, position.y, 1, 1));
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, 1, 1), imageRef);

    CGImageRelease(imageRef);
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);

	CGFloat alpha = rgba[3] / 255.0;
	CGFloat red   = (CGFloat)rgba[0] / rgba[3];
	CGFloat green = (CGFloat)rgba[1] / rgba[3];
	CGFloat blue  = (CGFloat)rgba[2] / rgba[3];

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - 二维码

+ (instancetype)lx_QRCodeImageWithMessage:(NSString *)message
                                     size:(CGSize)size
                                     logo:(nullable UIImage *)logo
								 logoSize:(CGSize)logoSize
                              transparent:(BOOL)transparent
{
    NSData *messageData = [message dataUsingEncoding:NSISOLatin1StringEncoding];
    CIFilter *QRCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [QRCodeFilter setValue:messageData forKey:@"inputMessage"];

    CIImage *outputImage = QRCodeFilter.outputImage;
    CGRect extent = outputImage.extent;
    CGImageRef outputCGImage = [[CIContext contextWithOptions:nil] createCGImage:outputImage fromRect:extent];

    if (transparent) {
        // 为了去除图片透明通道，需要重绘图片
        size_t pixelsWide = CGImageGetWidth(outputCGImage);
        size_t pixelsHigh = CGImageGetHeight(outputCGImage);
        size_t bitsPerComponent = 8;
        size_t bytesPerRow = pixelsWide * 4;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL,
                                                     pixelsWide,
                                                     pixelsHigh,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     colorSpace,
                                                     kCGImageAlphaNoneSkipLast);

        // 重绘图片去除透明通道，这样才能使用 CGImageCreateWithMaskingColors 函数
        CGContextDrawImage(context, LXRectMakeWithSize(extent.size), outputCGImage);
		CGImageRelease(outputCGImage);
        CGImageRef opaqueOutputCGImage = CGBitmapContextCreateImage(context);
		CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);

        // 去除白色背景
        const CGFloat components[6] = {255,255,255,255,255,255};
        outputCGImage = CGImageCreateWithMaskingColors(opaqueOutputCGImage, components);
        CGImageRelease(opaqueOutputCGImage);
    }

	CGFloat scale = [[UIScreen mainScreen] scale];
	size = LXSizeCeilInPixel(size, scale);
    UIGraphicsBeginImageContextWithOptions(size, !transparent, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 让二维码更清晰
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    // 翻转，不然是上下颠倒的
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, LXRectMakeWithSize(size), outputCGImage);
    CGImageRelease(outputCGImage);

    if (logo) {
		logoSize = LXSizeCeilInPixel(logoSize, scale);
		CGRect logoRect = LXRectMakeWithSize(logoSize);
		logoRect.origin.x = (size.width - logoSize.width) / 2;
		logoRect.origin.y = (size.height - logoSize.height) / 2;
		logoRect = LXRectFlatted(logoRect, scale);
        CGContextDrawImage(context, logoRect, logo.CGImage);
    }

    UIImage *QRCodeimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return QRCodeimage;
}

@end

NS_ASSUME_NONNULL_END
