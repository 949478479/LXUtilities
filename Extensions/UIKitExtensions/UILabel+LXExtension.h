//
//  UILabel+LXExtension.h
//
//  Created by 从今以后 on 16/6/30.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LXExtension)

@property (nonatomic, readonly) BOOL lx_hasText;

@property (nullable, nonatomic) IBInspectable UIColor *layerColor;

@end

NS_ASSUME_NONNULL_END
