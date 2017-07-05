//
//  UIApplication+LXExtension.m
//
//  Created by 从今以后 on 16/2/1.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UIApplication+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UIApplication (LXExtension)

+ (AppDelegate<UIApplicationDelegate> *)lx_delegate {
	return (AppDelegate<UIApplicationDelegate> *)[[self sharedApplication] delegate];
}

+ (BOOL)lx_openPrefsWithString:(NSString *)aString
{
    SEL classMethodSel = NSSelectorFromString(@"defaultWorkspace");
    Class class = NSClassFromString(@"LSApplicationWorkspace");
    id defaultWorkspace = ((id (*)(id, SEL))[class methodForSelector:classMethodSel])(class, classMethodSel);
    
    NSURL *url = [NSURL URLWithString:aString];
    SEL instanceMethodSel = NSSelectorFromString(@"openSensitiveURL:withOptions:");
    return ((BOOL (*)(id, SEL, id, id))[defaultWorkspace methodForSelector:instanceMethodSel])(defaultWorkspace, instanceMethodSel, url, nil);
}

@end

NS_ASSUME_NONNULL_END
