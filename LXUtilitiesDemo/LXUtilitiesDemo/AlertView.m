//
//  AlertView.m
//  LXUtilitiesDemo
//
//  Created by 冠霖环如 on 2017/9/21.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import "LXUtilities.h"
#import "AlertView.h"

@implementation AlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.shouldDismissOnTouchOutside = YES;
    }
    return self;
}

- (UIView *)alertView {
    return [[UINib nibWithNibName:@"AlertView" bundle:nil] instantiateWithOwner:nil options:nil][0];
}

@end
