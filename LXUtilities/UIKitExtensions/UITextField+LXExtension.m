//
//  UITextField+LXExtension.m
//
//  Created by 从今以后 on 15/9/11.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+LXExtension.h"
#import "UITextField+LXExtension.h"

#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"

@implementation UITextField (LXExtension)

#pragma mark - 方法交换

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self lx_exchangeMethodWithOriginalSelector:@selector(textRectForBounds:) swizzledSelector:@selector(lx_textRectForBounds:)];
        [self lx_exchangeMethodWithOriginalSelector:@selector(editingRectForBounds:) swizzledSelector:@selector(lx_editingRectForBounds:)];
        [self lx_exchangeMethodWithOriginalSelector:@selector(leftViewRectForBounds:) swizzledSelector:@selector(lx_leftViewRectForBounds:)];
        [self lx_exchangeMethodWithOriginalSelector:@selector(rightViewRectForBounds:) swizzledSelector:@selector(lx_rightViewRectForBounds:)];
        [self lx_exchangeMethodWithOriginalSelector:@selector(placeholderRectForBounds:) swizzledSelector:@selector(lx_placeholderRectForBounds:)];
    });
}

#pragma mark - 设置左右视图

- (void)setLx_leftViewImage:(UIImage *)leftViewImage {
    UIImageView *leftView = [[UIImageView alloc] initWithImage:leftViewImage];
    leftView.contentMode  = UIViewContentModeCenter;
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (UIImage *)lx_leftViewImage {
    if ([self.leftView isKindOfClass:[UIImageView class]]) {
        return ((UIImageView *)self.leftView).image;
    }
    return nil;
}

- (void)setLx_rightViewImage:(UIImage *)rightViewImage {
    UIButton *rightView = [UIButton new];
    [rightView setContentMode:UIViewContentModeCenter];
    [rightView setImage:rightViewImage forState:UIControlStateNormal];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UIImage *)lx_rightViewImage {
    if ([self.rightView isKindOfClass:[UIButton class]]) {
        return ((UIButton *)self.leftView).currentImage;
    }
    return nil;
}

#pragma mark - 设置左右视图范围

- (void)setLx_leftViewRect:(NSString *)leftViewRect {
    NSArray *components = leftViewRect ? [self lx_rectComponentsForRectString:leftViewRect] : nil;
    objc_setAssociatedObject(self, @selector(lx_leftViewRectComponents), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @selector(lx_leftViewRect), leftViewRect, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lx_leftViewRect {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSArray *)lx_leftViewRectComponents {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGRect)lx_leftViewRectForBounds:(CGRect)bounds
{
    NSArray *components = [self lx_leftViewRectComponents];
    CGRect originRect = [self lx_leftViewRectForBounds:bounds];
    if (components) {
        return [self lx_rectForOriginRect:originRect withRectComponents:components];
    }
    return originRect;
}

- (void)setLx_rightViewRect:(NSString *)rightViewRect {
    NSArray *components = rightViewRect ? [self lx_rectComponentsForRectString:rightViewRect] : nil;
    objc_setAssociatedObject(self, @selector(lx_rightViewRectComponents), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @selector(lx_rightViewRect), rightViewRect, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lx_rightViewRect {
    return objc_getAssociatedObject(self, _cmd);
}

- (NSArray *)lx_rightViewRectComponents {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGRect)lx_rightViewRectForBounds:(CGRect)bounds
{
    NSArray *components = [self lx_rightViewRectComponents];
    CGRect originRect = [self lx_rightViewRectForBounds:bounds];
    if (components) {
        return [self lx_rectForOriginRect:originRect withRectComponents:components];
    }
    return originRect;
}

#pragma mark - 设置编辑区域

- (void)setLx_editingRect:(NSString *)editingRect {
    NSArray *components = editingRect ? [self lx_rectComponentsForRectString:editingRect] : nil;
    objc_setAssociatedObject(self, @selector(lx_editingRectComponents), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, @selector(lx_editingRect), editingRect, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lx_editingRect {
	return objc_getAssociatedObject(self, _cmd);
}

- (NSArray *)lx_editingRectComponents {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGRect)lx_editingRectForBounds:(CGRect)bounds {
	NSArray *components = [self lx_editingRectComponents];
	CGRect originRect = [self lx_editingRectForBounds:bounds];
	if (components) {
		return [self lx_rectForOriginRect:originRect withRectComponents:components];
	}
	return originRect;
}

#pragma mark - 设置文本区域

- (void)setLx_textRect:(NSString *)textRect {
    NSArray *components = textRect ? [self lx_rectComponentsForRectString:textRect] : nil;
    objc_setAssociatedObject(self, @selector(lx_textRectComponents), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, @selector(lx_textRect), textRect, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lx_textRect {
	return objc_getAssociatedObject(self, _cmd);
}

- (NSArray *)lx_textRectComponents {
    return objc_getAssociatedObject(self, _cmd);
}

- (CGRect)lx_textRectForBounds:(CGRect)bounds {
	NSArray *components = [self lx_textRectComponents];
	CGRect originRect = [self lx_textRectForBounds:bounds];
	if (components) {
		return [self lx_rectForOriginRect:originRect withRectComponents:components];
	}
	return originRect;
}

#pragma mark - 设置占位符

- (void)setLx_placeholderColor:(UIColor *)placeholderColor {
    [self setValue:placeholderColor forKeyPath:@"placeholderLabel.textColor"];
}

- (UIColor *)lx_placeholderColor {
    return [self valueForKeyPath:@"placeholderLabel.textColor"];
}

- (void)setLx_placeholderFont:(UIFont *)placeholderFont {
	[self setValue:placeholderFont forKeyPath:@"placeholderLabel.font"];
}

- (UIFont *)lx_placeholderFont {
	return [self valueForKeyPath:@"placeholderLabel.font"];
}

- (void)setLx_placeholderRect:(NSString *)placeholderRect {
    NSArray *components = placeholderRect ? [self lx_rectComponentsForRectString:placeholderRect] : nil;
	objc_setAssociatedObject(self, @selector(lx_placeholderRectComponents), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, @selector(lx_placeholderRect), placeholderRect, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lx_placeholderRect {
	return objc_getAssociatedObject(self, _cmd);
}

- (NSArray *)lx_placeholderRectComponents {
	return objc_getAssociatedObject(self, _cmd);
}

- (CGRect)lx_placeholderRectForBounds:(CGRect)bounds
{
	NSArray *components = [self lx_placeholderRectComponents];
	CGRect originRect = [self lx_placeholderRectForBounds:bounds];
	if (components) {
		return [self lx_rectForOriginRect:originRect withRectComponents:components];
	}
	return originRect;
}

#pragma mark - 辅助方法

- (NSArray *)lx_rectComponentsForRectString:(NSString *)rectString {
    NSArray *components = [[rectString substringWithRange:(NSRange){1,rectString.length-2}] componentsSeparatedByString:@","];
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:4];
    for (NSString *character in components) {
        if ([character isEqualToString:@"*"]) {
            [values addObject:[NSNull null]];
        } else {
            [values addObject:@(character.doubleValue)];
        }
    }
    return values;
}

- (CGRect)lx_rectForOriginRect:(CGRect)originRect withRectComponents:(NSArray *)components {
    CGRect rect = {
        components[0] == [NSNull null] ? originRect.origin.x : [components[0] doubleValue],
        components[1] == [NSNull null] ? originRect.origin.y : [components[1] doubleValue],
        components[2] == [NSNull null] ? originRect.size.width : [components[2] doubleValue],
        components[3] == [NSNull null] ? originRect.size.height : [components[3] doubleValue],
    };
    return rect;
}

@end
