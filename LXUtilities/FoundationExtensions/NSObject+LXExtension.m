//
//  NSObject+LXExtension.m
//
//  Created by 从今以后 on 15/9/14.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "LXMacro.h"
#import <objc/runtime.h>
#import "NSObject+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

NSArray<NSString *> *lx_protocol_propertyList(Protocol *protocol)
{
    uint outCount = 0;
    objc_property_t *properties = protocol_copyPropertyList(protocol, &outCount);
    NSMutableArray *propertyList = [NSMutableArray arrayWithCapacity:outCount];
    for (uint i = 0; i< outCount; ++i) {
        [propertyList addObject:@(property_getName(properties[i]))];
    }
    lx_free(properties);
    return propertyList;
}

@interface _LXWeakBox : NSObject
@property (nullable, nonatomic, weak) id value;
@end
@implementation _LXWeakBox
@end

@implementation NSObject (LXExtension)

#pragma mark - 方法交换

#ifdef DEBUG
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self lx_exchangeMethodWithOriginalSelector:@selector(description) swizzledSelector:@selector(lx_description)];
    });
}
#endif

+ (void)lx_exchangeMethodWithOriginalSelector:(SEL)originalSel swizzledSelector:(SEL)swizzledSel
{
    NSParameterAssert(originalSel);
    NSParameterAssert(swizzledSel);

    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);

    IMP originalIMP = method_getImplementation(originalMethod);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);

    const char *swizzledTypes = method_getTypeEncoding(swizzledMethod);

    BOOL didAddMethod = class_addMethod(self, originalSel, swizzledIMP, swizzledTypes);

    if (didAddMethod) {
        method_setImplementation(swizzledMethod, originalIMP);
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark - 关联对象

- (void)lx_setRetainAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lx_setCopyAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)lx_setWeakAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key
{
    _LXWeakBox *box = objc_getAssociatedObject(self, key);
    if (!box) {
        box = [_LXWeakBox new];
        objc_setAssociatedObject(self, key, box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    box.value = value;
}

- (nullable id)lx_associatedValueForKey:(const void * _Nonnull)key
{
    id value = objc_getAssociatedObject(self, key);
    if ([value class] == [_LXWeakBox class]) {
        return [value value];
    }
    return value;
}

- (void)lx_removeAllAssociatedValues {
    objc_removeAssociatedObjects(self);
}

+ (void)lx_setRetainAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)lx_setCopyAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)lx_setWeakAssociatedValue:(nullable id)value forKey:(const void * _Nonnull)key
{
    _LXWeakBox *box = objc_getAssociatedObject(self, key);
    if (!box) {
        box = [_LXWeakBox new];
        objc_setAssociatedObject(self, key, box, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    box.value = value;
}

+ (nullable id)lx_associatedValueForKey:(const void * _Nonnull)key
{
    id value = objc_getAssociatedObject(self, key);
    if ([value class] == [_LXWeakBox class]) {
        return [value value];
    }
    return value;
}

+ (void)lx_removeAllAssociatedValues {
    objc_removeAssociatedObjects(self);
}

#pragma mark - KVO

- (void)lx_removeAllObservers
{
    for (id observance in [(__bridge id)[self observationInfo] valueForKey:@"observances"]) {
        [self removeObserver:[observance valueForKey:@"observer"]
                  forKeyPath:[observance valueForKeyPath:@"property.keyPath"]];
    }
}

#pragma mark - 调试增强

#ifdef DEBUG
- (NSString *)lx_description
{
    // 未采纳 LXDescriptionProtocol 协议则沿用默认实现
    if (![self conformsToProtocol:@protocol(LXDescriptionProtocol)]) {
        return [self lx_description];
    }

    // 获取类中所有属性名
    uint outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    NSMutableArray *propertyNameList = [NSMutableArray arrayWithCapacity:outCount];
    for (uint i = 0; i < outCount; ++i) {
        [propertyNameList addObject:@(property_getName(properties[i]))];
    }
    lx_free(properties);

    // 如下属性也会被获取到，忽略它们
    NSMutableSet *ignoredPropertyNames =
    [NSMutableSet setWithObjects:@"hash", @"superclass", @"description", @"debugDescription", nil];

    NSMutableDictionary *varInfo = [NSMutableDictionary new];
    for (NSString *propertyName in propertyNameList) {
        // 忽略需要忽略的属性
        if ([ignoredPropertyNames containsObject:propertyName]) {
            [ignoredPropertyNames removeObject:propertyName];
            continue;
        }
        // 若属性值为 nil 则显示 @"nil"
        id value = [self valueForKey:propertyName] ?: @"nil";
        // 若属性类型为布尔类型，则显示 @"YES" 或 @"NO"
        if (!strcmp(class_getName(object_getClass(value)), "__NSCFBoolean")) {
            value = [value boolValue] ? @"YES" : @"NO";
        }
        varInfo[propertyName] = value;
    }

    return [NSString stringWithFormat:@"<%@: %p>\n%@", self.class, self, varInfo];
}
#endif

@end

NS_ASSUME_NONNULL_END
