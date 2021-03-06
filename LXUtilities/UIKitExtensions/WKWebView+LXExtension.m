//
//  WKWebView+LXExtension.m
//
//  Created by 从今以后 on 16/10/10.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "WKWebView+LXExtension.h"

@implementation WKWebView (LXExtension)

- (void)lx_loadRequestWithURLString:(NSString *)URLString
{
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]];
}

- (UIImage *)lx_snapshot
{
    UIView *contentView = [self.scrollView valueForKey:@"_scrollNotificationViews"];
    UIGraphicsBeginImageContextWithOptions(contentView.bounds.size, NO, 0);
    [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

@end
