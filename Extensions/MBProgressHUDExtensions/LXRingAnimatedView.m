//
//  LXIndefiniteAnimatedView.m
//  这到底是什么鬼
//
//  Created by 从今以后 on 2017/6/5.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import "LXRingAnimatedView.h"

#define LXMINIMUM 0.0000001

@interface LXRingAnimatedView () <CAAnimationDelegate>
@property (nonatomic) CAShapeLayer *ringLayer;
@end

@implementation LXRingAnimatedView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = 3;
        _duration = .7;
        _ringRadius = 10;
        _ringColor = [UIColor colorWithRed:72./255 green:130./255 blue:244./255 alpha:1];

        _ringLayer = [CAShapeLayer new];
        _ringLayer.lineCap = kCALineCapRound;
        _ringLayer.fillColor = [UIColor clearColor].CGColor;
        _ringLayer.contentsScale = [UIScreen mainScreen].scale;
        _ringLayer.actions = @{ @"strokeEnd": [NSNull null], @"strokeStart": [NSNull null] };

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

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
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

- (void)_configureRing
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, 0, 0, self.ringRadius, 0, 2*M_PI * 7./8, NO);
    self.ringLayer.path = path;
    self.ringLayer.lineWidth = self.lineWidth;
    self.ringLayer.bounds = CGPathGetBoundingBox(path);
    self.ringLayer.strokeColor = self.ringColor.CGColor;
    CGPathRelease(path);
}

- (void)_startAnimation
{
    [self _stopAnimation];
    [self _configureRing];
    [self _addAnimation];
}

- (void)_stopAnimation {
    [self.ringLayer removeAllAnimations];
}

- (void)_addAnimation
{
    NSTimeInterval duration = self.duration;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    // end LXMINIMUM => 1
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEnd.fromValue = @(LXMINIMUM);
    strokeEnd.toValue = @1;
    strokeEnd.duration = duration;
    strokeEnd.timingFunction = timingFunction;

    // start 0 => 1 - LXMINIMUM
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStart.fromValue = @0;
    strokeStart.toValue = @(1 - LXMINIMUM);
    strokeStart.duration = duration;
    strokeStart.beginTime = duration;
    strokeStart.fillMode = kCAFillModeBackwards;
    strokeStart.timingFunction = timingFunction;

    // 转一周，等于没转
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.duration = duration * 2;
    rotation.values = @[@0, @(M_PI), @(2*M_PI)];
    rotation.timingFunctions = @[timingFunction, timingFunction];

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.duration = duration * 2;
    animationGroup.animations = @[strokeEnd, strokeStart, rotation];

    [self.ringLayer addAnimation:animationGroup forKey:nil];

    self.ringLayer.strokeEnd = 1;
    self.ringLayer.strokeStart = 1 - LXMINIMUM;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (!flag) {
        return;
    }

    self.ringLayer.strokeStart = 0;
    self.ringLayer.strokeEnd = LXMINIMUM;

    CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI * (1./4 + 7./4 * LXMINIMUM));
    CGPathRef path = CGPathCreateCopyByTransformingPath(self.ringLayer.path, &transform);
    self.ringLayer.path = path;
    CGPathRelease(path);
    
    [self _addAnimation];
}

/* 这个是旧版实现，不够完美。

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
*/

@end
