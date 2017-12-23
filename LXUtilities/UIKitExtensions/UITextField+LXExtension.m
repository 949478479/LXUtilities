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

@end
