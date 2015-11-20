//
//  LXRuntimeUtilities.m
//
//  Created by 从今以后 on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

@import ObjectiveC.runtime;
#import "LXRuntimeUtilities.h"

NS_ASSUME_NONNULL_BEGIN

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
