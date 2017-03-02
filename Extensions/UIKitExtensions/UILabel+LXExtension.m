//
//  UILabel+LXExtension.m
//
//  Created by 从今以后 on 16/6/30.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UILabel+LXExtension.h"

@implementation UILabel (LXExtension)

- (BOOL)lx_hasText
{
    return self.text.length > 0;
}

- (void)setLayerColor:(UIColor *)layerColor
{
	self.layer.backgroundColor = layerColor.CGColor;
}

- (UIColor *)layerColor
{
	return [UIColor colorWithCGColor:self.layer.backgroundColor];
}

@end
