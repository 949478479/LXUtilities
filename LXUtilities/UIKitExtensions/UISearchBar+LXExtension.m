//
//  UISearchBar+LXExtension.m
//  XWZUserClient
//
//  Created by 从今以后 on 16/8/16.
//  Copyright © 2016年 创意时代. All rights reserved.
//

#import "UISearchBar+LXExtension.h"

@implementation UISearchBar (LXExtension)

- (void)setTextColor:(UIColor *)textColor
{
    self.lx_textField.textColor = textColor;
}

- (UIColor *)textColor
{
    return self.lx_textField.textColor;
}

- (UITextField *)lx_textField
{
    return [self valueForKey:@"_searchField"];
}

@end
