//
//  UIWebView+LXExtension.m
//
//  Created by 从今以后 on 16/7/7.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UIWebView+LXExtension.h"

@implementation UIWebView (LXExtension)

- (JSContext *)lx_JSContext
{
    return [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
}

- (void)lx_loadRequestWithURLString:(NSString *)URLString
{
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]];
}

@end
