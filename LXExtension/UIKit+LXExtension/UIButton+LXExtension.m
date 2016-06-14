//
//  UIButton+LXExtension.m
//
//  Created by 从今以后 on 15/9/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIButton+LXExtension.h"

@implementation UIButton (LXExtension)

#pragma mark - 设置和获取标题 -

- (void)setLx_normalTitle:(NSString *)lx_normalTitle
{
    [self setTitle:lx_normalTitle forState:UIControlStateNormal];
}

- (NSString *)lx_normalTitle
{
    return [self titleForState:UIControlStateNormal];
}

- (void)setLx_disabledTitle:(NSString *)lx_disabledTitle
{
    [self setTitle:lx_disabledTitle forState:UIControlStateDisabled];
}

- (NSString *)lx_disabledTitle
{
    return [self titleForState:UIControlStateDisabled];
}

- (void)setLx_selectedTitle:(NSString *)lx_selectedTitle
{
    [self setTitle:lx_selectedTitle forState:UIControlStateSelected];
}

- (NSString *)lx_selectedTitle
{
    return [self titleForState:UIControlStateSelected];
}

- (void)setLx_highlightedTitle:(NSString *)lx_highlightedTitle
{
    [self setTitle:lx_highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)lx_highlightedTitle
{
    return [self titleForState:UIControlStateHighlighted];
}

#pragma mark - 设置和获取标题颜色 -

- (void)setLx_normalTitleColor:(UIColor *)lx_normalTitleColor
{
    [self setTitleColor:lx_normalTitleColor forState:UIControlStateNormal];
}

- (UIColor *)lx_normalTitleColor
{
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setLx_disabledTitleColor:(UIColor *)lx_disabledTitleColor
{
    [self setTitleColor:lx_disabledTitleColor forState:UIControlStateDisabled];
}

- (UIColor *)lx_disabledTitleColor
{
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)setLx_selectedTitleColor:(UIColor *)lx_selectedTitleColor
{
    [self setTitleColor:lx_selectedTitleColor forState:UIControlStateSelected];
}

- (UIColor *)lx_selectedTitleColor
{
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setLx_highlightedTitleColor:(UIColor *)lx_highlightedTitleColor
{
    [self setTitleColor:lx_highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)lx_highlightedTitleColor
{
    return [self titleColorForState:UIControlStateHighlighted];
}

#pragma mark - 设置和获取图片 -

- (void)setLx_normalImage:(UIImage *)lx_normalImage
{
    [self setImage:lx_normalImage forState:UIControlStateNormal];
}

- (UIImage *)lx_normalImage
{
    return [self imageForState:UIControlStateNormal];
}

- (void)setLx_disabledImage:(UIImage *)lx_disabledImage
{
    [self setImage:lx_disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)lx_disabledImage
{
    return [self imageForState:UIControlStateDisabled];
}

- (void)setLx_selectedImage:(UIImage *)lx_selectedImage
{
    [self setImage:lx_selectedImage forState:UIControlStateSelected];
}

- (UIImage *)lx_selectedImage
{
    return [self imageForState:UIControlStateSelected];
}

- (void)setLx_highlightedImage:(UIImage *)lx_highlightedImage
{
    [self setImage:lx_highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)lx_highlightedImage
{
    return [self imageForState:UIControlStateHighlighted];
}

#pragma mark - 设置和获取背景图片 -

- (void)setLx_normalBackgroundImage:(UIImage *)lx_normalBackgroundImage
{
    [self setBackgroundImage:lx_normalBackgroundImage forState:UIControlStateNormal];
}

- (UIImage *)lx_normalBackgroundImage
{
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setLx_disabledBackgroundImage:(UIImage *)lx_disabledBackgroundImage
{
    [self setBackgroundImage:lx_disabledBackgroundImage forState:UIControlStateDisabled];
}

- (UIImage *)lx_disabledBackgroundImage
{
    return [self imageForState:UIControlStateDisabled];
}

- (void)setLx_selectedBackgroundImage:(UIImage *)lx_selectedBackgroundImage
{
    [self setBackgroundImage:lx_selectedBackgroundImage forState:UIControlStateSelected];
}

- (UIImage *)lx_selectedBackgroundImage
{
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setLx_highlightedBackgroundImage:(UIImage *)lx_highlightedBackgroundImage
{
    [self setBackgroundImage:lx_highlightedBackgroundImage forState:UIControlStateHighlighted];
}

- (UIImage *)lx_highlightedBackgroundImage
{
    return [self backgroundImageForState:UIControlStateHighlighted];
}

#pragma mark - 设置标签背景色

- (void)setLabelBgColor:(UIColor *)labelBgColor
{
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.backgroundColor = labelBgColor;
}

- (UIColor *)labelBgColor
{
    return self.titleLabel.backgroundColor;
}

@end
