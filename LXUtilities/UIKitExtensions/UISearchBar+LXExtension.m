//
//  UISearchBar+LXExtension.m
//
//  Created by 从今以后 on 16/8/16.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UISearchBar+LXExtension.h"

@implementation UISearchBar (LXExtension)

- (void)setTextColor:(UIColor *)textColor {
    self.lx_textField.textColor = textColor;
}

- (UIColor *)textColor {
    return self.lx_textField.textColor;
}

- (UITextField *)lx_textField {
    return [self valueForKey:@"_searchField"];
}

- (void)lx_setSearchIconColor:(UIColor *)color
{
    UIImageView *iconView =  (UIImageView *)self.lx_textField.leftView;
    iconView.image = [iconView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    iconView.tintColor = color;
}

@end
