//
//  CALayer+LXExtension.h
//
//  Created by 从今以后 on 15/10/5.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import QuartzCore;

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (LXExtension)

///-------------------------------------
/// @name 几何布局（基于 frame 而非 bounds）
///-------------------------------------

#pragma mark - 布局

@property (nonatomic) CGSize  lx_size;
@property (nonatomic) CGFloat lx_width;
@property (nonatomic) CGFloat lx_height;

@property (nonatomic) CGPoint lx_origin;
@property (nonatomic) CGFloat lx_originX;
@property (nonatomic) CGFloat lx_originY;

@property (nonatomic) CGFloat lx_positionX;
@property (nonatomic) CGFloat lx_positionY;

///-----------
/// @name 动画
///-----------

#pragma mark - 动画

/// 暂停、恢复动画
@property (nonatomic, getter=lx_isPaused) BOOL lx_paused;

/// 添加动画，动画完成或被移除时调用闭包，注意不要设置动画代理,否则会造成覆盖。
- (void)lx_addAnimation:(CAAnimation *)anim
				 forKey:(nullable NSString *)key
			 completion:(void (^)(BOOL finished))completion;
@end

NS_ASSUME_NONNULL_END
