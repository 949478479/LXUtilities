//
//  CALayer+LXExtension.m
//
//  Created by 从今以后 on 15/10/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CALayer+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface _LXAnimationDelegate : NSObject
@end
@implementation _LXAnimationDelegate {
    void (^_completion)(BOOL finished);
}

- (instancetype)initWithCompletion:(void (^)(BOOL finished))completion
{
    self = [super init];
    if (self) {
        _completion = completion;
    }
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _completion(flag);
}

@end

@implementation CALayer (LXExtension)

#pragma mark - Bounds|Frame -

#pragma mark size

- (void)setLx_size:(CGSize)lx_size
{
    CGRect frame = self.frame;
    frame.size   = lx_size;
    self.frame   = frame;
}

- (CGSize)lx_size
{
    return self.frame.size;
}

- (void)setLx_width:(CGFloat)lx_width
{
    CGRect frame     = self.frame;
    frame.size.width = lx_width;
    self.frame       = frame;
}

- (CGFloat)lx_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setLx_height:(CGFloat)lx_height
{
    CGRect frame      = self.frame;
    frame.size.height = lx_height;
    self.frame        = frame;
}

- (CGFloat)lx_height
{
    return CGRectGetHeight(self.frame);
}

#pragma mark origin

- (void)setLx_origin:(CGPoint)lx_origin
{
    CGRect frame = self.frame;
    frame.origin = lx_origin;
    self.frame   = frame;
}

- (CGPoint)lx_origin
{
    return self.frame.origin;
}

- (void)setLx_originX:(CGFloat)lx_originX
{
    CGRect frame   = self.frame;
    frame.origin.x = lx_originX;
    self.frame     = frame;
}

- (CGFloat)lx_originX
{
    return CGRectGetMinX(self.frame);
}

- (void)setLx_originY:(CGFloat)lx_originY
{
    CGRect frame   = self.frame;
    frame.origin.y = lx_originY;
    self.frame     = frame;
}

- (CGFloat)lx_originY
{
    return CGRectGetMinY(self.frame);
}

#pragma mark position

- (void)setLx_positionX:(CGFloat)lx_positionX
{
    CGPoint position = self.position;
    position.x       = lx_positionX;
    self.position    = position;
}

- (CGFloat)lx_positionX
{
    return self.position.x;
}

- (void)setLx_positionY:(CGFloat)lx_positionY
{
    CGPoint position = self.position;
    position.y       = lx_positionY;
    self.position    = position;
}

- (CGFloat)lx_positionY
{
    return self.position.y;
}

#pragma mark - 动画 -

- (void)lx_addAnimationWithDuration:(NSTimeInterval)duration
                            keyPath:(nullable NSString *)keyPath
                         animations:(void (^)(CABasicAnimation *animation))animations
{
    [self lx_addAnimationWithDuration:duration
                                delay:0
                              keyPath:keyPath
                                  key:nil
                           animations:animations
                           completion:nil];
}

- (void)lx_addAnimationWithDuration:(NSTimeInterval)duration
                            keyPath:(nullable NSString *)keyPath
                         animations:(void (^)(CABasicAnimation *animation))animations
                         completion:(nullable void (^)(BOOL finished))completion
{
    [self lx_addAnimationWithDuration:duration
                                delay:0
                              keyPath:keyPath
                                  key:nil
                           animations:animations
                           completion:completion];
}

- (void)lx_addAnimationWithDuration:(NSTimeInterval)duration
                              delay:(NSTimeInterval)delay
                            keyPath:(nullable NSString *)keyPath
                         animations:(void (^)(CABasicAnimation *animation))animations
                         completion:(nullable void (^)(BOOL finished))completion
{
    [self lx_addAnimationWithDuration:duration
                                delay:delay
                              keyPath:keyPath
                                  key:nil
                           animations:animations
                           completion:completion];
}

- (void)lx_addAnimationWithDuration:(NSTimeInterval)duration
                              delay:(NSTimeInterval)delay
                            keyPath:(nullable NSString *)keyPath
                                key:(nullable NSString *)key
                         animations:(void (^)(CABasicAnimation *animation))animations
                         completion:(nullable void (^)(BOOL finished))completion
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.duration  = duration;
    animation.beginTime = CACurrentMediaTime() + delay;
    animation.fillMode  = kCAFillModeBackwards;
    animations(animation);
    if (completion) {
        animation.delegate = [[_LXAnimationDelegate alloc] initWithCompletion:completion];
    }
    [self addAnimation:animation forKey:key];
}

@end

NS_ASSUME_NONNULL_END
