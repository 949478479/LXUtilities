//
//  NSURLRequest+LXExtension.m
//
//  Created by 从今以后 on 16/6/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "NSURLRequest+LXExtension.h"

@implementation NSURLRequest (LXExtension)

+ (instancetype)lx_requestWithURLString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSAssert(url, @"urlString 无法创建 NSURL 实例");
    return [self requestWithURL:url];
}

@end
