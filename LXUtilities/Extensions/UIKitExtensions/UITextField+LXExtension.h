//
//  UITextField+LXExtension.h
//
//  Created by 从今以后 on 15/9/11.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (LXExtension)

/// 设置文本区域，即 @c -[UITextField textRectForBounds:] 方法的返回值。
/// 格式为：{x,y,w,h}，例如：{1,2,3,4}。
/// 若忽略某个值，使用*替代数字，将沿用超类实现提供的值。
@property (nullable, nonatomic) IBInspectable NSString *textRect;

/// 设置编辑区域，即 @c -[UITextField editingRectForBounds:] 方法的返回值。
/// 格式为：{x,y,w,h}，例如：{1,2,3,4}。
/// 若忽略某个值，使用*替代数字，将沿用超类实现提供的值。
@property (nullable, nonatomic) IBInspectable NSString *editingRect;

/// 设置占位文本区域，即 @c -[UITextField placeholderRectForBounds:] 方法的返回值。
/// 格式为：{x,y,w,h}，例如：{1,2,3,4}。
/// 若忽略某个值，使用*替代数字，将沿用超类实现提供的值。
@property (nullable, nonatomic) IBInspectable NSString *placeholderRect;

/// 设置左视图区域，即 @c -[UITextField leftViewRectForBounds:] 方法的返回值。
/// 格式为：{x,y,w,h}，例如：{1,2,3,4}。
/// 若忽略某个值，使用*替代数字，将沿用超类实现提供的值。
@property (nullable, nonatomic) IBInspectable NSString *leftViewRect;
/// 为 @c UITextField 设置始终显示的左视图 UIImageView，图片居中显示
@property (nullable, nonatomic) IBInspectable UIImage *leftViewImage;

/// 设置右视图区域，即 @c -[UITextField rightViewRectForBounds:] 方法的返回值。
/// 格式为：{x,y,w,h}，例如：{1,2,3,4}。
/// 若忽略某个值，使用*替代数字，将沿用超类实现提供的值。
@property (nullable, nonatomic) IBInspectable NSString *rightViewRect;
/// 为 @c UITextField 设置始终显示的右视图 UIButton，图片居中显示
@property (nullable, nonatomic) IBInspectable UIImage *rightViewImage;

/// 占位文字颜色
@property (nonatomic) IBInspectable UIColor *placeholderColor;
/// 占位文字字体
@property (nonatomic) UIFont *placeholderFont;

@end

NS_ASSUME_NONNULL_END
