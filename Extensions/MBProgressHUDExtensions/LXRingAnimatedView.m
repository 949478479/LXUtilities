//
//  LXIndefiniteAnimatedView.m
//  这到底是什么鬼
//
//  Created by 从今以后 on 2017/6/5.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import "LXRingAnimatedView.h"

#define LXMINIMUM 0.000001

@interface LXRingAnimatedView ()
@property (nonatomic) CAShapeLayer *ringLayer;
@end

@implementation LXRingAnimatedView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _duration = .5;
        _lineWidth = 4;
        _ringRadius = 20;
        _ringColor = [UIColor blackColor];

        _ringLayer = [CAShapeLayer new];
        _ringLayer.fillColor = nil;
        _ringLayer.lineCap = kCALineCapRound;
        _ringLayer.contentsScale = [UIScreen mainScreen].scale;

        [self.layer addSublayer:_ringLayer];
    }
    return self;
}

#pragma mark - 布局

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];

    self.ringLayer.position = CGPointMake(CGRectGetMidX(layer.bounds), CGRectGetMidY(layer.bounds));
}

- (CGSize)intrinsicContentSize
{
    CGFloat diameter = self.ringRadius * 2 + self.lineWidth;
    return CGSizeMake(diameter, diameter);
}

#pragma mark - 动画

- (void)didMoveToWindow
{
    [super didMoveToWindow];

    if (self.window) {
        [self _startAnimation];
    } else {
        [self _stopAnimation];
    }
}

- (void)_configureRingLayer
{
    CGFloat diameter = self.ringRadius * 2;
    CGRect bounds = { .size = { diameter, diameter} };
    CGPathRef path = CGPathCreateWithEllipseInRect(bounds, NULL);

    self.ringLayer.bounds = bounds;
    self.ringLayer.path = CFAutorelease(path);
    self.ringLayer.lineWidth = self.lineWidth;
    self.ringLayer.strokeColor = self.ringColor.CGColor;
}

- (void)_stopAnimation {
    [self.ringLayer removeAllAnimations];
}

- (void)_startAnimation
{
    [self _stopAnimation];
    [self _configureRingLayer];

    uint index = 0;
    CGFloat radian = M_PI_4 * 3;
    NSTimeInterval duration = self.duration;
    NSMutableArray *animations = [NSMutableArray arrayWithCapacity:4];

    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];

    rotation.duration = duration;
    strokeEnd.duration = duration;
    strokeStart.duration = duration;

    rotation.fillMode = kCAFillModeForwards;
    strokeEnd.fillMode = kCAFillModeForwards;
    strokeStart.fillMode = kCAFillModeForwards;

    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotation.timingFunction = timingFunction;
    strokeEnd.timingFunction = timingFunction;
    strokeStart.timingFunction = timingFunction;

    // end: LXMINIMUM => 3/4

    rotation.byValue = @(radian);
    strokeEnd.toValue = @(3 / 4.0);
    strokeEnd.fromValue = @(LXMINIMUM);

    [animations addObject:rotation.copy];
    [animations addObject:strokeEnd.copy];

    ++index;

    // start: 0 => 3/4 - LXMINIMUM

    rotation.beginTime = duration * index;
    strokeStart.beginTime = duration * index;

    rotation.byValue = @(radian);
    strokeStart.fromValue = @0;
    strokeStart.toValue = @(3 / 4.0 - LXMINIMUM);

    [animations addObject:rotation.copy];
    [animations addObject:strokeStart.copy];

    ++index;

    // start: 3/4 - LXMINIMUM => 0

    rotation.beginTime = duration * index;
    strokeStart.beginTime = duration * index;

    strokeStart.toValue = @0;
    strokeStart.fromValue = @(3 / 4.0 - LXMINIMUM);
    rotation.byValue = @(radian + 2 * M_PI * 3 / 4.0);

    [animations addObject:rotation.copy];
    [animations addObject:strokeStart.copy];

    ++index;

    // end 3/4 => LXMINIMUM

    rotation.beginTime = duration * index;
    strokeEnd.beginTime = duration * index;

    strokeEnd.fromValue = @(3 / 4.0);
    strokeEnd.toValue = @(LXMINIMUM);
    rotation.byValue = @(radian + 2 * M_PI * 3 / 4.0);

    [animations addObject:rotation.copy];
    [animations addObject:strokeEnd.copy];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.repeatCount = INFINITY;
    animationGroup.duration = duration * 4;
    animationGroup.animations = animations;

    [self.ringLayer addAnimation:animationGroup forKey:nil];
}

@end
