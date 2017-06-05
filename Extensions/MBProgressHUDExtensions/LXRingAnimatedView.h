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

/// 圆弧线条宽度，默认 2pt
@property (nonatomic) CGFloat lineWidth;
/// 半径，默认 20pt
@property (nonatomic) CGFloat ringRadius;
/// 圆弧颜色，默认黑色
@property (nonatomic) UIColor *ringColor;
/// 单次动画持续时间，默认 1s
@property (nonatomic) NSTimeInterval duration;

/// 开启动画
- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
