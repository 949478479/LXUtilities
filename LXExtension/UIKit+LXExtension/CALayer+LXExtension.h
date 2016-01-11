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

/// 暂停、恢复动画
@property (nonatomic) BOOL lx_paused;

/**
 *  为图层添加动画。
 *
 *  @param key               动画的 key。
 *  @param modelLayerUpdater 在此 block 中更新图层属性不会触发隐式动画。
 *  @param completion        动画停止时调用此 block，不要设置动画代理。
 */
- (void)lx_addAnimation:(CAAnimation *)anim
                 forKey:(nullable NSString *)key
      modelLayerUpdater:(void (^)(void))modelLayerUpdater
             completion:(nullable void(^)(BOOL finished))completion;
/**
 *  为图层添加动画。
 *
 *  @param key               动画的 key。
 *  @param modelLayerUpdater 在此 block 中更新图层属性不会触发隐式动画。
 */
- (void)lx_addAnimation:(CAAnimation *)anim
                 forKey:(nullable NSString *)key
      modelLayerUpdater:(void (^)(void))modelLayerUpdater;
/**
 *  为图层添加动画。
 *
 *  @param key               动画的 key。
 *  @param completion        动画停止时调用此 block，不要设置动画代理。
 */
- (void)lx_addAnimation:(CAAnimation *)anim
                 forKey:(nullable NSString *)key
             completion:(nullable void(^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
