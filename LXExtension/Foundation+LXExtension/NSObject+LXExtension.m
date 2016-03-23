//
//  NSObject+LXExtension.m
//
//  Created by 从今以后 on 15/9/14.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import ObjectiveC.runtime;
#import "LXUtilities.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSObject (LXExtension)

#pragma mark - 方法交换 -

#ifdef DEBUG
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LXMethodSwizzling(self, @selector(description), @selector(lx_description));
    });
}
#endif

#pragma mark - 关联对象 -

- (void)lx_setValue:(nullable id)value forKey:(NSString *)key
{
    objc_setAssociatedObject(self, NSSelectorFromString(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (nullable id)lx_valueForKey:(NSString *)key
{
    return objc_getAssociatedObject(self, NSSelectorFromString(key));
}

#pragma mark - KVO -

- (void)lx_removeAllObservers
{
    for (id observance in [(__bridge id)[self observationInfo] valueForKey:@"observances"]) {
        [self removeObserver:[observance valueForKey:@"observer"]
                  forKeyPath:[observance valueForKeyPath:@"property.keyPath"]];
    }
}

#pragma mark - 调试增强 -

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
    LXFree(properties);

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
