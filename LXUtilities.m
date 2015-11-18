//
//  LXUtilities.m
//
//  Created by 从今以后 on 15/9/12.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;
@import ObjectiveC.runtime;

#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 版本号

NSString * LXBundleVersionString()
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

NSString * LXBundleShortVersionString()
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

#pragma mark - 沙盒路径

NSString * LXDocumentDirectory()
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

NSString * LXDocumentDirectoryByAppendingPathComponent(NSString *pathComponent)
{
    return [LXDocumentDirectory() stringByAppendingPathComponent:pathComponent];
}

NSString * LXLibraryDirectory()
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

NSString * LXLibraryDirectoryByAppendingPathComponent(NSString *pathComponent)
{
    return [LXLibraryDirectory() stringByAppendingPathComponent:pathComponent];
}

NSString * LXCachesDirectory()
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

NSString * LXCachesDirectoryByAppendingPathComponent(NSString *pathComponent)
{
    return [LXCachesDirectory() stringByAppendingPathComponent:pathComponent];
}

#pragma mark - 设备信息

BOOL LXDeviceIsPad()
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

#pragma mark - AppDelegate

id<UIApplicationDelegate> LXAppDelegate()
{
    return [UIApplication sharedApplication].delegate;
}

#pragma mark - 屏幕|窗口|控制器

CGSize LXScreenSize()
{
    return [UIScreen mainScreen].bounds.size;
}

CGFloat LXScreenScale()
{
    return [UIScreen mainScreen].scale;
}

UIWindow * LXKeyWindow()
{
    return [UIApplication sharedApplication].keyWindow ?: LXAppDelegate().window;
}

UIWindow * LXTopWindow()
{
    return [UIApplication sharedApplication].windows.lastObject ?: LXAppDelegate().window;
}

UIViewController * LXTopViewController()
{
    UIViewController *rootVC = LXKeyWindow().rootViewController;
    UIViewController *topVC  = rootVC.presentedViewController;

    return topVC ?: rootVC;
}

UIViewController * LXRootViewController()
{
    return LXKeyWindow().rootViewController;
}

#pragma mark - GCD

dispatch_source_t lx_dispatch_source_timer(NSTimeInterval secondInterval,
                                           NSTimeInterval secondLeeway,
                                           dispatch_block_t handler,
                                           _Nullable dispatch_block_t cancelHandler)
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, secondInterval * NSEC_PER_SEC, secondLeeway * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, handler);
    if (cancelHandler) {
        dispatch_source_set_cancel_handler(timer, cancelHandler);
    }
    return timer;
}

void lx_dispatch_after(NSTimeInterval delayInSeconds, dispatch_block_t handler)
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), handler);
}

#pragma mark - runtime

void LXMethodSwizzling(Class cls, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);

    IMP originalIMP = method_getImplementation(originalMethod);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);

    const char *swizzledTypes = method_getTypeEncoding(swizzledMethod);

    // 避免当前类未重写父类方法实现时覆盖掉父类的实现.
    BOOL didAddMethod = class_addMethod(cls, originalSelector, swizzledIMP, swizzledTypes);

    if (didAddMethod) {
        // 根据 class_replaceMethod 函数的说明,在此情况下应该是和 method_setImplementation 函数等效的.
        method_setImplementation(swizzledMethod, originalIMP);
    } else {
        // 若子类已经实现原始方法,class_addMethod 函数没有效果,且函数返回值为 NO ,这时候直接交换即可.
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

NSArray<NSString *> * lx_protocol_propertyList(Protocol *protocol)
{
    NSMutableArray *propertyList = [NSMutableArray new];
    {
        uint outCount = 0;
        objc_property_t *properties = protocol_copyPropertyList(protocol, &outCount);
        for (uint i = 0; i< outCount; ++i) {
            [propertyList addObject:[NSString stringWithUTF8String:property_getName(properties[i])]];
        }
        free(properties);
    }
    return propertyList;
}

NS_ASSUME_NONNULL_END
