//
//  UIView+LXExtension.m
//
//  Created by 从今以后 on 15/9/11.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "UIView+LXExtension.h"
#import "CALayer+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIView (LXExtension)

#pragma mark size

- (void)lx_setSize:(CGSize)lx_size
{
    CGRect frame = self.frame;
    frame.size = lx_size;
    self.frame = frame;
}

- (CGSize)lx_size {
    return self.frame.size;
}

- (void)lx_setWidth:(CGFloat)lx_width
{
    CGRect frame = self.frame;
    frame.size.width = lx_width;
    self.frame = frame;
}

- (CGFloat)lx_width {
    return self.frame.size.width;
}

- (void)lx_setHeight:(CGFloat)lx_height
{
    CGRect frame = self.frame;
    frame.size.height = lx_height;
    self.frame = frame;
}

- (CGFloat)lx_height {
    return self.frame.size.height;
}

#pragma mark origin

- (void)lx_setOrigin:(CGPoint)lx_origin
{
    CGRect frame = self.frame;
    frame.origin = lx_origin;
    self.frame = frame;
}

- (CGPoint)lx_origin {
    return self.frame.origin;
}

- (void)lx_setOriginX:(CGFloat)lx_originX
{
    CGRect frame = self.frame;
    frame.origin.x = lx_originX;
    self.frame = frame;
}

- (CGFloat)lx_originX {
    return self.frame.origin.x;
}

- (void)lx_setOriginY:(CGFloat)lx_originY
{
    CGRect frame = self.frame;
    frame.origin.y = lx_originY;
    self.frame = frame;
}

- (CGFloat)lx_originY {
    return self.frame.origin.y;
}

#pragma mark center

- (void)lx_setCenterX:(CGFloat)lx_centerX {
	self.center = (CGPoint){ lx_centerX, self.center.y };
}

- (CGFloat)lx_centerX {
    return self.center.x;
}

- (void)lx_setCenterY:(CGFloat)lx_centerY {
	self.center = (CGPoint){ self.center.x, lx_centerY };
}

- (CGFloat)lx_centerY {
    return self.center.y;
}

- (CGFloat)lx_minX {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)lx_minY {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)lx_maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)lx_maxY {
    return CGRectGetMaxY(self.frame);
}

#pragma mark - 光栅化

- (void)setShouldRasterize:(BOOL)shouldRasterize
{
    self.layer.shouldRasterize = shouldRasterize;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (BOOL)shouldRasterize {
    return self.layer.shouldRasterize;
}

#pragma mark 圆角

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

#pragma mark 边框

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth / [[UIScreen mainScreen] scale];
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    CGColorRef color = self.layer.borderColor;
    return [UIColor colorWithCGColor:color];
}

#pragma mark 阴影

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowOpacity:(float)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (float)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (UIColor *)shadowColor
{
    CGColorRef color = self.layer.shadowColor;
    return [UIColor colorWithCGColor:color];
}

#pragma mark - 视图控制器

- (nullable __kindof UIViewController *)lx_viewController
{
	UIResponder *responder = self.nextResponder;
	for (Class cls = [UIViewController class]; responder && ![responder isKindOfClass:cls];) {
		responder = responder.nextResponder;
	}
	return (UIViewController * _Nullable)responder;
}

#pragma mark - xib

+ (UINib *)lx_nib {
    return [UINib nibWithNibName:[self lx_nibName] bundle:nil];
}

+ (NSString *)lx_nibName {
    return [NSStringFromClass(self) componentsSeparatedByString:@"."].lastObject;
}

+ (instancetype)lx_instantiateFromNib {
    return [self lx_instantiateFromNibWithOwner:nil options:nil];
}

+ (instancetype)lx_instantiateFromNibWithOwner:(nullable id)ownerOrNil
                                       options:(nullable NSDictionary *)optionsOrNil
{
    NSArray *views = [[self lx_nib] instantiateWithOwner:ownerOrNil options:optionsOrNil];
    for (UIView *view in views) {
        if ([view isMemberOfClass:self]) {
            return view;
        }
    }
    NSAssert(NO, @"%@.xib 中未找到对应的 %@", NSStringFromClass(self), NSStringFromClass(self));
    return nil;
}

#pragma mark - 动画

- (void)setLx_paused:(BOOL)lx_paused {
	self.layer.lx_paused = lx_paused;
}

- (BOOL)lx_paused {
	return self.layer.lx_paused;
}

- (void)lx_performShakeAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];

    animation.keyPath  = @"position.x";
    animation.values   = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    animation.additive = YES;

    [self.layer addAnimation:animation forKey:@"shake"];
}

@end

NS_ASSUME_NONNULL_END
