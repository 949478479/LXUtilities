//
//  UIApplication+LXExtension.m
//
//  Created by 从今以后 on 16/2/1.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UIApplication+LXExtension.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@implementation UIApplication (LXExtension)

+ (AppDelegate<UIApplicationDelegate> *)lx_delegate {
	return (AppDelegate<UIApplicationDelegate> *)[[self sharedApplication] delegate];
}

+ (BOOL)lx_openPrefsWithString:(NSString *)aString
{
	char className[] = { 0x4c, 0x53, 0x41, 0x70, 0x70, 0x6c, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x57, 0x6f, 0x72, 0x6b, 0x73, 0x70, 0x61, 0x63, 0x65, 0x0 };
	Class class = objc_lookUpClass(className);
	char classMethodSelName[] = { 0x64, 0x65, 0x66, 0x61, 0x75, 0x6c, 0x74, 0x57, 0x6f, 0x72, 0x6b, 0x73, 0x70, 0x61, 0x63, 0x65, 0x0 };
	SEL classMethodSel = sel_registerName(classMethodSelName);
	id defaultWorkspace = ((id (*)(id, SEL))[class methodForSelector:classMethodSel])(class, classMethodSel);

	char instanceMethodSelName[] = { 0x6f, 0x70, 0x65, 0x6e, 0x53, 0x65, 0x6e, 0x73, 0x69, 0x74, 0x69, 0x76, 0x65, 0x55, 0x52, 0x4c, 0x3a, 0x77, 0x69, 0x74, 0x68, 0x4f, 0x70, 0x74, 0x69, 0x6f, 0x6e, 0x73, 0x3a, 0x0 };
	SEL instanceMethodSel = sel_registerName(instanceMethodSelName);
	NSURL *url = [NSURL URLWithString:aString];
	return ((BOOL (*)(id, SEL, id, id))[defaultWorkspace methodForSelector:instanceMethodSel])(defaultWorkspace, instanceMethodSel, url, nil);
}

@end

NS_ASSUME_NONNULL_END
