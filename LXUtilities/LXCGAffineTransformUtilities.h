//
//  LXCGAffineTransformUtilities.h
//
//  Created by 从今以后 on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

@import CoreGraphics.CGAffineTransform;

static inline CGAffineTransform CGAffineTransformMakeScaleTranslate(CGFloat sx,
                                                                    CGFloat sy,
                                                                    CGFloat tx,
                                                                    CGFloat ty)
{
    return CGAffineTransformMake(sx, 0, 0, sy, tx, ty);
}
