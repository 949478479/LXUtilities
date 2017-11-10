//
//  UISearchBar+LXExtension.h
//
//  Created by 从今以后 on 16/8/16.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (LXExtension)

@property (nullable, nonatomic) IBInspectable UIColor *textColor;

@property (nonatomic, readonly) UITextField *lx_textField;

- (void)lx_setSearchIconColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
