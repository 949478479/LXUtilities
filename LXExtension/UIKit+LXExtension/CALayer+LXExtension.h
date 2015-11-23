//
//  CALayer+LXExtension.h
//
//  Created by 从今以后 on 15/10/5.
//  Copyright © 2015年 apple. All rights reserved.
//

@import QuartzCore;

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (LXExtension)

#pragma mark - Bounds|Frame -

///-------------------
/// @name Bounds|Frame
///-------------------

@property (nonatomic) CGSize  lx_size;
@property (nonatomic) CGFloat lx_width;
@property (nonatomic) CGFloat lx_height;

@property (nonatomic) CGPoint lx_origin;
@property (nonatomic) CGFloat lx_originX;
@property (nonatomic) CGFloat lx_originY;

@property (nonatomic) CGFloat lx_positionX;
@property (nonatomic) CGFloat lx_positionY;

#pragma mark - 动画 -

///-----------
/// @name 动画
///-----------

/**
 *  为图层添加 @c CABasicAnimation 动画，@c fillMode 为 @c kCAFillModeBackwards。
 *
 *  @param duration   动画的持续时间，关联 @c duration 属性。
 *  @param keyPath    动画的 key-path，关联 @c keyPath 属性。
 *  @param animations 在此 block 内设置 @c CABasicAnimation 的其他属性，例如 @c fromValue，@c byValue 等。
 */
- (void)lx_addAnimationWithDuration:(NSTimeInterval)duration
                            keyPath:(nullable NSString *)keyPath
                         animations:(void (^)(CABasicAnimation *animation))animations;

/**
 *  为图层添加 @c CABasicAnimation 动画，@c fillMode 为 @c kCAFillModeBackwards。
 *
 *  @param duration   动画的持续时间，关联 @c duration 属性。
 *  @param keyPath    动画的 key-path，关联 @c keyPath 属性。
 *  @param animations 在此 block 内设置 @c CABasicAnimation 的其他属性，例如 @c fromValue，@c byValue 等。
 *  @param completion 动画停止时调用此 block。若正常结束，则 @c finished 为 @c YES，否则为 @c NO。
 */
- (void)lx_addAnimationWithDuration:(NSTimeInterval)duration
                            keyPath:(nullable NSString *)keyPath
                         animations:(void (^)(CABasicAnimation *animation))animations
                         completion:(nullable void (^)(BOOL finished))completion;

/**
 *  为图层添加 @c CABasicAnimation 动画，@c fillMode 为 @c kCAFillModeBackwards。
 *
 *  @param duration   动画的持续时间，关联 @c duration 属性。
 *  @param delay      动画的延迟时间，关联 @c beginTime 属性。例如延迟 1s，则设置为 1。
 *  @param keyPath    动画的 key-path，关联 @c keyPath 属性。
 *  @param animations 在此 block 内设置 @c CABasicAnimation 的其他属性，例如 @c fromValue，@c byValue 等。
 *  @param completion 动画停止时调用此 block。若正常结束，则 @c finished 为 @c YES，否则为 @c NO。
 */
- (void)lx_addAnimationWithDuration:(NSTimeInterval)duration
                              delay:(NSTimeInterval)delay
                            keyPath:(nullable NSString *)keyPath
                         animations:(void (^)(CABasicAnimation *animation))animations
                         completion:(nullable void (^)(BOOL finished))completion;

/**
 *  为图层添加 @c CABasicAnimation 动画，@c fillMode 为 @c kCAFillModeBackwards。
 *
 *  @param duration   动画的持续时间，关联 @c duration 属性。
 *  @param delay      动画的延迟时间，关联 @c beginTime 属性。例如延迟 1s，则设置为 1。
 *  @param keyPath    动画的 key-path，关联 @c keyPath 属性。
 *  @param key        动画的 key。
 *  @param animations 在此 block 内设置 @c CABasicAnimation 的其他属性，例如 @c fromValue，@c byValue 等。
 *  @param completion 动画停止时调用此 block。若正常结束，则 @c finished 为 @c YES，否则为 @c NO。
 */
- (void)lx_addAnimationWithDuration:(NSTimeInterval)duration
                              delay:(NSTimeInterval)delay
                            keyPath:(nullable NSString *)keyPath
                                key:(nullable NSString *)key
                         animations:(void (^)(CABasicAnimation *animation))animations
                         completion:(nullable void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
