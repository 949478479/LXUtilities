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

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self lx_exchangeOriginalSEL:@selector(textRectForBounds:) swizzledSEL:@selector(lx_textRectForBounds:)];
        [self lx_exchangeOriginalSEL:@selector(editingRectForBounds:) swizzledSEL:@selector(lx_editingRectForBounds:)];
        [self lx_exchangeOriginalSEL:@selector(leftViewRectForBounds:) swizzledSEL:@selector(lx_leftViewRectForBounds:)];
        [self lx_exchangeOriginalSEL:@selector(rightViewRectForBounds:) swizzledSEL:@selector(lx_rightViewRectForBounds:)];
    });
}

#pragma mark - 设置左右视图

- (void)setLeftViewImage:(UIImage *)leftViewImage
{
    UIImageView *leftView = [[UIImageView alloc] initWithImage:leftViewImage];
    leftView.contentMode  = UIViewContentModeCenter;
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (UIImage *)leftViewImage
{
    if ([self.leftView isKindOfClass:[UIImageView class]]) {
        return ((UIImageView *)self.leftView).image;
    }
    return nil;
}

- (void)setRightViewImage:(UIImage *)rightViewImage
{
    UIButton *rightView = [UIButton new];
    [rightView setContentMode:UIViewContentModeCenter];
    [rightView setImage:rightViewImage forState:UIControlStateNormal];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UIImage *)rightViewImage
{
    if ([self.rightView isKindOfClass:[UIButton class]]) {
        return ((UIButton *)self.leftView).currentImage;
    }
    return nil;
}

#pragma mark - 调整 frame 的辅助函数

static inline CGRect LXAdjustRectForOldRectAndNewRect(CGRect oldRect, CGRect newRect)
{
    if (CGRectIsEmpty(newRect)) {
        return oldRect;
    }

    CGSize  oldSize   = oldRect.size;
    CGPoint oldOrigin = oldRect.origin;

    CGSize  newSize   = newRect.size;
    CGPoint newOrigin = newRect.origin;

    return (CGRect) {
        {
            newOrigin.x >= 0 ? newOrigin.x : oldOrigin.x,
            newOrigin.y >= 0 ? newOrigin.y : oldOrigin.y,
        },
        {
            newSize.width >= 0 ? newSize.width : oldSize.width - (newOrigin.x - oldOrigin.x),
            newSize.height >= 0 ? newSize.height : oldSize.height - (newOrigin.y - oldOrigin.y),
        },
    };
}

#pragma mark - 设置编辑区域 frame

- (void)setEditingRect:(CGRect)editingRect
{
    objc_setAssociatedObject(self,
                             @selector(editingRect),
                             [NSValue valueWithCGRect:editingRect],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)editingRect
{
    return [objc_getAssociatedObject(self, _cmd) CGRectValue];
}

- (CGRect)lx_editingRectForBounds:(CGRect)bounds
{
    CGRect newRect = [self editingRect];
    CGRect oldRect = [self lx_editingRectForBounds:bounds];
    return LXAdjustRectForOldRectAndNewRect(oldRect, newRect);
}

#pragma mark - 设置文本区域 frame

- (void)setTextRect:(CGRect)textRect
{
    objc_setAssociatedObject(self,
                             @selector(textRect),
                             [NSValue valueWithCGRect:textRect],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)textRect
{
    return [objc_getAssociatedObject(self, _cmd) CGRectValue];
}

- (CGRect)lx_textRectForBounds:(CGRect)bounds
{
    CGRect newRect = [self textRect];
    CGRect oldRect = [self lx_textRectForBounds:bounds];
    return LXAdjustRectForOldRectAndNewRect(oldRect, newRect);
}

#pragma mark - 设置左右视图 frame

- (void)setLeftViewSize:(CGSize)leftViewSize
{
    objc_setAssociatedObject(self,
                             @selector(leftViewSize),
                             [NSValue valueWithCGSize:leftViewSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)leftViewSize
{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (CGRect)lx_leftViewRectForBounds:(CGRect)bounds
{
    self.leftView.bounds = (CGRect){.size = [self leftViewSize]};
    return [self lx_leftViewRectForBounds:bounds];
}

- (void)setRightViewSize:(CGSize)rightViewSize
{
    objc_setAssociatedObject(self,
                             @selector(rightViewSize),
                             [NSValue valueWithCGSize:rightViewSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)rightViewSize
{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (CGRect)lx_rightViewRectForBounds:(CGRect)bounds
{
    self.rightView.bounds = (CGRect){.size = [self rightViewSize]};
    return [self lx_rightViewRectForBounds:bounds];
}

#pragma mark - 设置占位文字颜色

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [self setValue:placeholderColor forKeyPath:@"placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:@"placeholderLabel.textColor"];
}

@end
