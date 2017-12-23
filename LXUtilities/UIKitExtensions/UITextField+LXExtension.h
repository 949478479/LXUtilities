//
//  UITextField+LXExtension.h
//
//  Created by 从今以后 on 15/9/11.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (LXExtension)

/// 为 @c UITextField 设置始终显示的左视图 UIImageView，图片居中显示
@property (nullable, nonatomic) IBInspectable UIImage *lx_leftViewImage;
/// 为 @c UITextField 设置始终显示的右视图 UIButton，图片居中显示
@property (nullable, nonatomic) IBInspectable UIImage *lx_rightViewImage;

/// 占位文字颜色
@property (nonatomic) IBInspectable UIColor *lx_placeholderColor NS_SWIFT_UNAVAILABLE("Use lx.placeholderColor instead.");
/// 占位文字字体
@property (nonatomic) UIFont *lx_placeholderFont;

@end

NS_ASSUME_NONNULL_END
