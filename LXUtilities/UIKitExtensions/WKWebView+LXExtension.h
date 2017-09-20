//
//  WKWebView+LXExtension.h
//
//  Created by 从今以后 on 16/10/10.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (LXExtension)

- (void)lx_loadRequestWithURLString:(NSString *)URLString;

/// 对网页内容截图
- (UIImage *)lx_snapshot;

@end
