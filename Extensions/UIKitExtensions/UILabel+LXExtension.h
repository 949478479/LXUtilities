//
//  UILabel+LXExtension.h
//
//  Created by 从今以后 on 16/6/30.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LXExtension)

@property (nonatomic, readonly) BOOL lx_hasText;

/*
 UILabel 和 UITextView 要想显示圆角需要表现出与周围不同的背景色才行。
 想要在 UILabel 和 UITextView 上实现低成本的圆角（不触发离屏渲染），
 需要保证 layer 的 contents 呈现透明的背景色，
 文本视图类的 layer 的 contents 默认是透明的（字符就在这个透明的环境里绘制、显示），
 此时只需要设置 layer 的 backgroundColor，再加上 cornerRadius 就可以搞定了。
 不过 UILabel 上设置 backgroundColor 的行为被更改了，
 不再是设定 layer 的背景色而是为 contents 设置背景色，
 UITextView 则没有改变这一点，所以在 UILabel 上实现圆角要这么做：

 label.layer.backgroundColor = aColor
 label.layer.cornerRadius = 5

 而不要这么做：
 
 label.backgroundColor = aColor 
 */
@property (nullable, nonatomic) IBInspectable UIColor *layerColor;

@end

NS_ASSUME_NONNULL_END
