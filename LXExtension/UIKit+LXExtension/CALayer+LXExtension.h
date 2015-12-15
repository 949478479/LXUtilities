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
 *  为图层添加 @c CABasicAnimation 动画。
 *
 *  @param key        动画的 key。
 *  @param completion 动画停止时调用此 block。若正常结束，则 @c finished 为 @c YES，否则为 @c NO。
 */
- (void)lx_addAnimation:(CAAnimation *)anim
                 forKey:(nullable NSString *)key
             completion:(nullable void(^)(BOOL finished))completion;
@end

NS_ASSUME_NONNULL_END
