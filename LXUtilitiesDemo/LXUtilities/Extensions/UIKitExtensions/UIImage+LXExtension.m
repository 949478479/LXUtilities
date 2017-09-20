//
//  UIImage+LXExtension.m
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import <AVFoundation/AVUtilities.h>
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

+ (nullable instancetype)lx_imageWithColor:(UIColor *)color {
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

	CGSize contextSize = CGSizeZero;
	CGRect drawingRect = CGRectZero;
	if (contentMode == UIViewContentModeScaleToFill) {
		contextSize = size;
		drawingRect.size = size;
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
		drawingRect.size = CGSizeMake(imageSize.width * ratio, imageSize.height * ratio);
		if (contentMode == UIViewContentModeScaleAspectFill) {
			contextSize = size;
			drawingRect.origin.x = (size.width - drawingRect.size.width) / 2;
			drawingRect.origin.y = (size.height - drawingRect.size.height) / 2;
			drawingRect = LXRectFlatted(drawingRect, self.scale);
		} else {
			drawingRect.size = LXSizeCeilInPixel(drawingRect.size, self.scale);
			contextSize = drawingRect.size;
		}
	}

	UIGraphicsBeginImageContextWithOptions(contextSize, self.lx_opaque, self.scale);
    [self drawInRect:drawingRect];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (CGRect)lx_rectWithAspectRatioInsideRect:(CGRect)boundingRect {
    return LXRectFlatted(AVMakeRectWithAspectRatioInsideRect(self.size, boundingRect), [[UIScreen mainScreen] scale]);
}

#pragma mark - 图片裁剪

- (UIImage *)lx_imageWithClippedRect:(CGRect)rect
{
	// 要裁剪的区域比自身大，所以不用裁剪直接返回自身即可
	if (CGRectContainsRect(rect, LXRectMakeWithSize(self.size))) {
		return self;
	}

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
	CGRect imageRect = CGRectMake(0, 0, width, height);

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
	CGContextDrawImage(context, imageRect, self.CGImage);
	CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
	CGColorSpaceRelease(colorSpace);
	CGContextRelease(context);

	if (self.lx_opaque) {
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
	// 用 CGBitmapContextCreateImage 方式创建出来的图片
	// CGImageAlphaInfo 总是为 CGImageAlphaInfoNone
	// 导致 qmui_opaque 与原图不一致，所以这里再做多一步
	UIGraphicsBeginImageContextWithOptions(maskedGrayImage.size, NO, maskedGrayImage.scale);
	[maskedGrayImage drawInRect:imageRect];
	maskedGrayImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
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
	UIGraphicsBeginImageContextWithOptions(self.size, self.lx_opaque, self.scale);
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

#pragma mark - 图片信息

- (BOOL)lx_opaque
{
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
	BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipFirst
	|| alphaInfo == kCGImageAlphaNoneSkipLast
	|| alphaInfo == kCGImageAlphaNone;
	return opaque;
}

- (UIColor *)lx_averageColor
{
	unsigned char rgba[4] = {};
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host;
	CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, bitmapInfo);
	CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
	CGColorSpaceRelease(colorSpace);
	CGContextRelease(context);
	if (rgba[0] > 0) {
		return [UIColor colorWithRed:(CGFloat)rgba[1] / rgba[0]
							   green:(CGFloat)rgba[2] / rgba[0]
								blue:(CGFloat)rgba[3] / rgba[0]
							   alpha:(CGFloat)rgba[0] / 255.0];
	} else {
		return [UIColor colorWithRed:rgba[1] / 255.0
							   green:rgba[2] / 255.0
								blue:rgba[3] / 255.0
							   alpha:0];
	}
}

- (UIColor *)lx_pixelColorAtPosition:(CGPoint)position
{
	position = LXPointRound(position);

	unsigned char rgba[4] = {};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host;
    CGContextRef bitmapContext = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(position.x, position.y, 1, 1));
    CGContextDrawImage(bitmapContext, CGRectMake(0, 0, 1, 1), imageRef);

    CGImageRelease(imageRef);
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);

	CGFloat alpha = rgba[0] / 255.0;
	CGFloat red   = (CGFloat)rgba[1] / rgba[0];
	CGFloat green = (CGFloat)rgba[2] / rgba[0];
	CGFloat blue  = (CGFloat)rgba[3] / rgba[0];

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - 二维码

+ (instancetype)lx_QRCodeImageWithMessage:(NSString *)message
                                     size:(CGSize)size
                                     logo:(nullable UIImage *)logo
								 logoSize:(CGSize)logoSize
                          foregroundColor:(nullable UIColor *)foregroundColor
                          backgroundColor:(nullable UIColor *)backgroundColor
{
    NSData *messageData = [message dataUsingEncoding:NSISOLatin1StringEncoding];
    CIFilter *QRCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [QRCodeFilter setValue:messageData forKey:@"inputMessage"];
    [QRCodeFilter setValue:@"H" forKey:@"inputCorrectionLevel"];

    CIImage *outputCIImage = QRCodeFilter.outputImage;
    CGRect extent = outputCIImage.extent;
    CGImageRef outputCGImage = [[CIContext new] createCGImage:outputCIImage fromRect:extent];
    
    if (foregroundColor || backgroundColor) {
        size_t pixelsWide = CGImageGetWidth(outputCGImage);
        size_t pixelsHigh = CGImageGetHeight(outputCGImage);
        size_t countOfPixels = pixelsWide * pixelsHigh;
        UInt32 *pixels = calloc(countOfPixels, sizeof(UInt32));
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Host;
        CGContextRef context = CGBitmapContextCreate(pixels, pixelsWide, pixelsHigh, 8, 4 * pixelsWide, colorSpace, bitmapInfo);
        CGContextDrawImage(context, LXRectMakeWithSize(extent.size), outputCGImage);
        
        CGFloat fRed = 0, fGreen = 0, fBlue = 0;
        CGFloat bRed = 0, bGreen = 0, bBlue = 0, bAlpha = 0;
        [foregroundColor getRed:&fRed green:&fGreen blue:&fBlue alpha:NULL];
        [backgroundColor getRed:&bRed green:&bGreen blue:&bBlue alpha:&bAlpha];
        
        UInt8 *components = NULL;
        UInt32 *currentPixel = pixels;
        for (size_t i = 0; i < countOfPixels; ++i) {
            components = (UInt8 *)currentPixel;
            if (*currentPixel == 0xFF000000) { // 黑色，即前景
                if (foregroundColor) {
                    components[2] = fRed   * 255.0; // R
                    components[1] = fGreen * 255.0; // G
                    components[0] = fBlue  * 255.0; // B
                }
            } else if (backgroundColor) {
                if (bAlpha == 0.0) {
                    *currentPixel = 0;
                } else {
                    components[2] = bRed   * 255.0; // R
                    components[1] = bGreen * 255.0; // G
                    components[0] = bBlue  * 255.0; // B
                }
            }
            ++currentPixel;
        }
        
        CGImageRelease(outputCGImage);
        outputCGImage = CGBitmapContextCreateImage(context);
        
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        free(pixels);
    }

	CGFloat scale = [[UIScreen mainScreen] scale];
	size = LXSizeCeilInPixel(size, scale);
    UIGraphicsBeginImageContextWithOptions(size, ![backgroundColor isEqual:[UIColor clearColor]], scale);
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
