//
//  LXMessageInterceptor.h
//
//  Created by 从今以后 on 16/5/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXMessageInterceptor : NSProxy

- (instancetype)initWithMiddleMan:(id)middleMan;

@property (nullable, nonatomic, weak) id receiver;

@property (nonatomic, unsafe_unretained) id middleMan;

@end

NS_ASSUME_NONNULL_END
