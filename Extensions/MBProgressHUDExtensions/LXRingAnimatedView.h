//
//  LXIndefiniteAnimatedView.h
//  这到底是什么鬼
//
//  Created by 从今以后 on 2017/6/5.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXRingAnimatedView : UIView

/// 圆弧线条宽度，默认 3pt
@property (nonatomic) CGFloat lineWidth UI_APPEARANCE_SELECTOR;
/// 半径，默认 10pt
@property (nonatomic) CGFloat ringRadius UI_APPEARANCE_SELECTOR;
/// 圆弧颜色，默认使用 4882F4
@property (nonatomic) UIColor *ringColor UI_APPEARANCE_SELECTOR;
/// 单次动画持续时间，默认 0.8s
@property (nonatomic) NSTimeInterval duration UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
