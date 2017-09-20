//
//  UIButton+LXExtension.h
//
//  Created by 从今以后 on 15/9/21.
//  Copyright © 2015年 apple. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LXExtension)

@property (nullable, nonatomic, copy, setter=lx_setNormalTitle:) NSString *lx_normalTitle;
@property (nullable, nonatomic, copy, setter=lx_setDisabledTitle:) NSString *lx_disabledTitle;
@property (nullable, nonatomic, copy, setter=lx_setSelectedTitle:) NSString *lx_selectedTitle;
@property (nullable, nonatomic, copy, setter=lx_setHighlightedTitle:) NSString *lx_highlightedTitle;

@property (nullable, nonatomic, copy, setter=lx_setNormalTitleColor:) UIColor *lx_normalTitleColor;
@property (nullable, nonatomic, copy, setter=lx_setDisabledTitleColor:) UIColor *lx_disabledTitleColor;
@property (nullable, nonatomic, copy, setter=lx_setSelectedTitleColor:) UIColor *lx_selectedTitleColor;
@property (nullable, nonatomic, copy, setter=lx_setHighlightedTitleColor:) UIColor *lx_highlightedTitleColor;

@property (nullable, nonatomic, setter=lx_setNormalImage:) UIImage *lx_normalImage;
@property (nullable, nonatomic, setter=lx_setDisabledImage:) UIImage *lx_disabledImage;
@property (nullable, nonatomic, setter=lx_setSelectedImage:) UIImage *lx_selectedImage;
@property (nullable, nonatomic, setter=lx_setHighlightedImage:) UIImage *lx_highlightedImage;

@property (nullable, nonatomic, setter=lx_setNormalBackgroundImage:) UIImage *lx_normalBackgroundImage;
@property (nullable, nonatomic, setter=lx_setDisabledBackgroundImage:) UIImage *lx_disabledBackgroundImage;
@property (nullable, nonatomic, setter=lx_setSelectedBackgroundImage:) UIImage *lx_selectedBackgroundImage;
@property (nullable, nonatomic, setter=lx_setHighlightedBackgroundImage:) UIImage *lx_highlightedBackgroundImage;

@property (nullable, nonatomic) IBInspectable UIColor *labelBackgroundColor;
@property (nullable, nonatomic) IBInspectable UIColor *disabledBackgroundColor;
@property (nullable, nonatomic) IBInspectable UIColor *selectedBackgroundColor;
@property (nullable, nonatomic) IBInspectable UIColor *highlightedBackgroundColor;

@end

NS_ASSUME_NONNULL_END
