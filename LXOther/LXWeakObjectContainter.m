//
//  LXWeakObjectContainter.m
//
//  Created by 从今以后 on 16/1/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LXWeakObjectContainter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LXWeakObjectContainter

- (instancetype)initWithObject:(id)obj
{
    self = [super init];
    if (self) {
        _obj = obj;
    }
    return self;
}

+ (instancetype)containterWithObject:(id)obj
{
    return [[self alloc] initWithObject:obj];
}

@end

NS_ASSUME_NONNULL_END
