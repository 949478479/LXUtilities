//
//  LXWeakObjectContainter.h
//
//  Created by 从今以后 on 16/1/1.
//  Copyright © 2016年 apple. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface LXWeakObjectContainter : NSObject

@property (nonatomic, weak, readonly) id obj;

+ (instancetype)containterWithObject:(id)obj;

@end

NS_ASSUME_NONNULL_END
