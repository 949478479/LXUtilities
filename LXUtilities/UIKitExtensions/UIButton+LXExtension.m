//
//  UIButton+LXExtension.m
//
//  Created by 从今以后 on 15/9/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIImage+LXExtension.h"
#import "UIButton+LXExtension.h"
#import "NSObject+LXExtension.h"

@implementation UIButton (LXExtension)

#pragma mark - 设置和获取标题

- (void)lx_setNormalTitle:(NSString *)lx_normalTitle {
    [self setTitle:lx_normalTitle forState:UIControlStateNormal];
}

- (NSString *)lx_normalTitle {
    return [self titleForState:UIControlStateNormal];
}

- (void)lx_setDisabledTitle:(NSString *)lx_disabledTitle {
    [self setTitle:lx_disabledTitle forState:UIControlStateDisabled];
}

- (NSString *)lx_disabledTitle {
    return [self titleForState:UIControlStateDisabled];
}

- (void)lx_setSelectedTitle:(NSString *)lx_selectedTitle {
    [self setTitle:lx_selectedTitle forState:UIControlStateSelected];
}

- (NSString *)lx_selectedTitle {
    return [self titleForState:UIControlStateSelected];
}

- (void)lx_setHighlightedTitle:(NSString *)lx_highlightedTitle {
    [self setTitle:lx_highlightedTitle forState:UIControlStateHighlighted];
}

- (NSString *)lx_highlightedTitle {
    return [self titleForState:UIControlStateHighlighted];
}

#pragma mark - 设置和获取标题颜色

- (void)lx_setNormalTitleColor:(UIColor *)lx_normalTitleColor {
    [self setTitleColor:lx_normalTitleColor forState:UIControlStateNormal];
}

- (UIColor *)lx_normalTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}

- (void)lx_setDisabledTitleColor:(UIColor *)lx_disabledTitleColor {
    [self setTitleColor:lx_disabledTitleColor forState:UIControlStateDisabled];
}

- (UIColor *)lx_disabledTitleColor {
    return [self titleColorForState:UIControlStateDisabled];
}

- (void)lx_setSelectedTitleColor:(UIColor *)lx_selectedTitleColor {
    [self setTitleColor:lx_selectedTitleColor forState:UIControlStateSelected];
}

- (UIColor *)lx_selectedTitleColor {
    return [self titleColorForState:UIControlStateSelected];
}

- (void)lx_setHighlightedTitleColor:(UIColor *)lx_highlightedTitleColor {
    [self setTitleColor:lx_highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIColor *)lx_highlightedTitleColor {
    return [self titleColorForState:UIControlStateHighlighted];
}

#pragma mark - 设置和获取图片

- (void)lx_setNormalImage:(UIImage *)lx_normalImage {
    [self setImage:lx_normalImage forState:UIControlStateNormal];
}

- (UIImage *)lx_normalImage {
    return [self imageForState:UIControlStateNormal];
}

- (void)lx_setDisabledImage:(UIImage *)lx_disabledImage {
    [self setImage:lx_disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)lx_disabledImage {
    return [self imageForState:UIControlStateDisabled];
}

- (void)lx_setSelectedImage:(UIImage *)lx_selectedImage {
    [self setImage:lx_selectedImage forState:UIControlStateSelected];
}

- (UIImage *)lx_selectedImage {
    return [self imageForState:UIControlStateSelected];
}

- (void)lx_setHighlightedImage:(UIImage *)lx_highlightedImage {
    [self setImage:lx_highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)lx_highlightedImage {
    return [self imageForState:UIControlStateHighlighted];
}

#pragma mark - 设置和获取背景图片

- (void)lx_setNormalBackgroundImage:(UIImage *)lx_normalBackgroundImage {
    [self setBackgroundImage:lx_normalBackgroundImage forState:UIControlStateNormal];
}

- (UIImage *)lx_normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)lx_setDisabledBackgroundImage:(UIImage *)lx_disabledBackgroundImage {
    [self setBackgroundImage:lx_disabledBackgroundImage forState:UIControlStateDisabled];
}

- (UIImage *)lx_disabledBackgroundImage {
    return [self imageForState:UIControlStateDisabled];
}

- (void)lx_setSelectedBackgroundImage:(UIImage *)lx_selectedBackgroundImage {
    [self setBackgroundImage:lx_selectedBackgroundImage forState:UIControlStateSelected];
}

- (UIImage *)lx_selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)lx_setHighlightedBackgroundImage:(UIImage *)lx_highlightedBackgroundImage {
    [self setBackgroundImage:lx_highlightedBackgroundImage forState:UIControlStateHighlighted];
}

- (UIImage *)lx_highlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}

#pragma mark - 设置背景颜色

- (void)setLabelBackgroundColor:(UIColor *)labelBackgroundColor
{
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.backgroundColor = labelBackgroundColor;
}

- (UIColor *)labelBackgroundColor {
    return self.titleLabel.backgroundColor;
}

- (void)setDisabledBackgroundColor:(UIColor *)disabledBackgroundColor
{
    [self lx_associateValue:disabledBackgroundColor forKey:@"disabledBackgroundColor"];
    [self lx_setDisabledBackgroundImage:[UIImage lx_imageWithColor:disabledBackgroundColor]];
}

- (UIColor *)disabledBackgroundColor {
    return [self lx_associatedValueForKey:@"disabledBackgroundColor"];
}

- (void)setHighlightedBackgroundColor:(UIColor *)highlightedBackgroundColor
{
    [self lx_associateValue:highlightedBackgroundColor forKey:@"highlightedBackgroundColor"];
    [self lx_setHighlightedBackgroundImage:[UIImage lx_imageWithColor:highlightedBackgroundColor]];
}

- (UIColor *)highlightedBackgroundColor {
    return [self lx_associatedValueForKey:@"highlightedBackgroundColor"];
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor
{
    [self lx_associateValue:selectedBackgroundColor forKey:@"selectedBackgroundColor"];
    [self lx_setSelectedBackgroundImage:[UIImage lx_imageWithColor:selectedBackgroundColor]];
}

- (UIColor *)selectedBackgroundColor {
    return [self lx_associatedValueForKey:@"selectedBackgroundColor"];
}

@end
