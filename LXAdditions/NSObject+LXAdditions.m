//
//  NSObject+LXAdditions.m
//
//  Created by 从今以后 on 15/9/14.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import ObjectiveC.runtime;
#import "LXUtilities.h"
#import "NSObject+LXAdditions.h"

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation NSObject (LXAdditions)

#pragma mark - 方法交换

#ifdef DEBUG
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LXMethodSwizzling(self, @selector(description), @selector(lx_description));
    });
}
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 获取属性数组

+ (NSArray<NSString *> *)lx_propertyList
{
    NSMutableArray *propertyArray = [NSMutableArray new];
    {
        uint outCount = 0;
        objc_property_t *properties = class_copyPropertyList(self, &outCount);
        for (uint i = 0; i < outCount; ++i) {
            [propertyArray addObject:
             (NSString *)[NSString stringWithUTF8String:property_getName(properties[i])]];
        }
        free(properties);
    }
    return propertyArray;
}

- (NSArray<NSString *> *)lx_propertyList
{
    return self.class.lx_propertyList;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 获取实例变量数组

+ (NSArray<NSString *> *)lx_ivarList
{
    NSMutableArray *ivarArray = [NSMutableArray new];
    {
        uint outCount = 0;
        Ivar *ivars = class_copyIvarList(self, &outCount);
        for (uint i = 0; i < outCount; ++i) {
            [ivarArray addObject:
             (NSString *)[NSString stringWithUTF8String:ivar_getName(ivars[i])]];
        }
        free(ivars);
    }
    return ivarArray;
}

- (NSArray<NSString *> *)lx_ivarList
{
    return self.class.lx_ivarList;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 调试

#ifdef DEBUG
- (NSString *)lx_description
{
    if (![self conformsToProtocol:@protocol(LXDescription)]) {
        return [self lx_description];
    }

    NSMutableDictionary *varInfo = [NSMutableDictionary new];
    for (NSString *varName in self.lx_ivarList) {
        id value = [self valueForKey:varName] ?: @"nil";
        if ([value class] == objc_lookUpClass("__NSCFBoolean")) { // 私有类,仅仅在 debug 模式下用用.
            value = [value boolValue] ? @"YES" : @"NO";
        }
        varInfo[varName] = value;
    }
    return [NSString stringWithFormat:@"<%@: %p>\n%@", self.class, self, varInfo];
}
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - 关联对象

- (void)lx_setValue:(id)value forKey:(NSString *)key
{
    NSAssert(key.length, @"参数 key 为空字符串或 nil.");

    objc_setAssociatedObject(self, NSSelectorFromString(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)lx_valueForKey:(NSString *)key
{
    NSAssert(key.length, @"参数 key 为空字符串或 nil.");
    
    return objc_getAssociatedObject(self, NSSelectorFromString(key));
}

@end