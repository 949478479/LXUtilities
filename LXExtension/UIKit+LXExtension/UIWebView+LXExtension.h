//
//  UIWebView+LXExtension.h
//
//  Created by 从今以后 on 16/7/7.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JSContext;

NS_ASSUME_NONNULL_BEGIN

@interface UIWebView (LXExtension)

@property (nonatomic, readonly) JSContext *lx_JSContext;

- (void)lx_loadRequestWithURLString:(NSString *)URLString;

/// 对网页内容截图
- (UIImage *)lx_snapshot;

@end

NS_ASSUME_NONNULL_END
