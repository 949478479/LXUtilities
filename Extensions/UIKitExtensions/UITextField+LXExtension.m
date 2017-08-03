//
//  UITextField+LXExtension.m
//
//  Created by 从今以后 on 15/9/11.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import ObjectiveC.runtime;
#import "NSObject+LXExtension.h"
#import "UITextField+LXExtension.h"

#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"

@implementation UITextField (LXExtension)

#pragma mark - 方法交换

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self lx_exchangeOriginalSEL:@selector(textRectForBounds:) swizzledSEL:@selector(lx_textRectForBounds:)];
        [self lx_exchangeOriginalSEL:@selector(editingRectForBounds:) swizzledSEL:@selector(lx_editingRectForBounds:)];
        [self lx_exchangeOriginalSEL:@selector(leftViewRectForBounds:) swizzledSEL:@selector(lx_leftViewRectForBounds:)];
        [self lx_exchangeOriginalSEL:@selector(rightViewRectForBounds:) swizzledSEL:@selector(lx_rightViewRectForBounds:)];
		[self lx_exchangeOriginalSEL:@selector(placeholderRectForBounds:) swizzledSEL:@selector(lx_placeholderRectForBounds:)];
    });
}

#pragma mark - 设置左右视图

- (void)setLeftViewImage:(UIImage *)leftViewImage {
    UIImageView *leftView = [[UIImageView alloc] initWithImage:leftViewImage];
    leftView.contentMode  = UIViewContentModeCenter;
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (UIImage *)leftViewImage {
    if ([self.leftView isKindOfClass:[UIImageView class]]) {
        return ((UIImageView *)self.leftView).image;
    }
    return nil;
}

- (void)setRightViewImage:(UIImage *)rightViewImage {
    UIButton *rightView = [UIButton new];
    [rightView setContentMode:UIViewContentModeCenter];
    [rightView setImage:rightViewImage forState:UIControlStateNormal];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UIImage *)rightViewImage {
    if ([self.rightView isKindOfClass:[UIButton class]]) {
        return ((UIButton *)self.leftView).currentImage;
    }
    return nil;
}

- (void)setLeftViewSize:(CGSize)leftViewSize {
	objc_setAssociatedObject(self, @selector(leftViewSize), [NSValue valueWithCGSize:leftViewSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)leftViewSize {
	return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (CGRect)lx_leftViewRectForBounds:(CGRect)bounds {
	self.leftView.bounds = (CGRect){.size = [self leftViewSize]};
	return [self lx_leftViewRectForBounds:bounds];
}

- (void)setRightViewSize:(CGSize)rightViewSize {
	objc_setAssociatedObject(self, @selector(rightViewSize), [NSValue valueWithCGSize:rightViewSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)rightViewSize {
	return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (CGRect)lx_rightViewRectForBounds:(CGRect)bounds {
	self.rightView.bounds = (CGRect){.size = [self rightViewSize]};
	return [self lx_rightViewRectForBounds:bounds];
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

#pragma mark - 设置编辑区域

- (void)setEditingRect:(NSString *)editingRect {
	NSArray *components = [self lx_rectComponentsForRectString:editingRect];
    objc_setAssociatedObject(self, @selector(lx_editingRectComponents), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, @selector(editingRect), editingRect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)editingRect {
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

- (void)setTextRect:(NSString *)textRect {
	NSArray *components = [self lx_rectComponentsForRectString:textRect];
    objc_setAssociatedObject(self, @selector(lx_textRectComponents), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, @selector(textRect), textRect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)textRect {
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

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    [self setValue:placeholderColor forKeyPath:@"placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor {
    return [self valueForKeyPath:@"placeholderLabel.textColor"];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
	[self setValue:placeholderFont forKeyPath:@"placeholderLabel.font"];
}

- (UIFont *)placeholderFont {
	return [self valueForKeyPath:@"placeholderLabel.font"];
}

- (void)setPlaceholderRect:(NSString *)placeholderRect {
	NSArray *components = [self lx_rectComponentsForRectString:placeholderRect];
	objc_setAssociatedObject(self, @selector(lx_placeholderRectComponents), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, @selector(placeholderRect), placeholderRect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)placeholderRect {
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

@end
