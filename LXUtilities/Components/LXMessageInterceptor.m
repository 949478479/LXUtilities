//
//  LXMessageInterceptor.m
//
//  Created by 从今以后 on 16/5/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "LXMessageInterceptor.h"

@implementation LXMessageInterceptor

- (instancetype)initWithMiddleMan:(id)middleMan
{
    _middleMan = middleMan;
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([_middleMan respondsToSelector:aSelector]) {
        return _middleMan;
    }

    if ([_receiver respondsToSelector:aSelector]) {
        return _receiver;
    }

    return nil;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([_middleMan respondsToSelector:aSelector]) {
        return YES;
    }

    if ([_receiver respondsToSelector:aSelector]) {
        return YES;
    }

    return NO;
}

@end
