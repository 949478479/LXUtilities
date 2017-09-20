//
//  NSURLRequest+LXExtension.h
//
//  Created by 从今以后 on 16/6/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLRequest (LXExtension)

+ (instancetype)lx_requestWithURLString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
