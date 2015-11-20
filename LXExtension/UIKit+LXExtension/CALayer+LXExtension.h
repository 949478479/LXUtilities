//
//  CALayer+LXExtension.h
//
//  Created by 从今以后 on 15/10/5.
//  Copyright © 2015年 apple. All rights reserved.
//

@import QuartzCore;

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (LXExtension)

@property (nonatomic) CGSize  lx_size;
@property (nonatomic) CGFloat lx_width;
@property (nonatomic) CGFloat lx_height;

@property (nonatomic) CGPoint lx_origin;
@property (nonatomic) CGFloat lx_originX;
@property (nonatomic) CGFloat lx_originY;

@property (nonatomic) CGFloat lx_positionX;
@property (nonatomic) CGFloat lx_positionY;

@end

NS_ASSUME_NONNULL_END
