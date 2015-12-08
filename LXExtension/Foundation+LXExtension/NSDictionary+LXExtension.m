//
//  NSDictionary+LXExtension.m
//
//  Created by 从今以后 on 15/10/10.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@protocol LXDescriptionProtocol;
#import "LXMacro.h"
#import "NSDictionary+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSDictionary (LXExtension)

#pragma mark - 函数式便捷方法 -

- (NSArray *)lx_map:(id _Nullable (^)(id _Nonnull, id _Nonnull))map
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];

    if (self.count == 0) return array;

    [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key,
                                              id _Nonnull obj,
                                              BOOL * _Nonnull stop) {
        id result = map(key, obj);
        if (result) [array addObject:result];
    }];

    return array; // 出于性能考虑就不 copy 了。
}

- (instancetype)lx_filter:(BOOL (^)(id _Nonnull, id _Nonnull))filter
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:self.count];

    if (self.count == 0) return dict;

    [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key,
                                              id _Nonnull obj,
                                              BOOL * _Nonnull stop) {
        if (filter(key, obj)) dict[key] = obj;
    }];

    return dict; // 出于性能考虑就不 copy 了。
}

#pragma mark - 打印对齐 -

LX_DIAGNOSTIC_PUSH_IGNORED(-Wat-protocol)
- (NSString *)descriptionWithLocale:(nullable id)locale
{
    NSMutableString *description = [NSMutableString stringWithString:@"{\n"];

    [self enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableString *subDescription = [NSMutableString stringWithFormat:@"    %@ = %@;\n", key, obj];
        if ([obj isKindOfClass:NSArray.self] ||
            [obj isKindOfClass:NSDictionary.self] ||
            [obj conformsToProtocol:@protocol(LXDescriptionProtocol)]) {
            [subDescription replaceOccurrencesOfString:@"\n"
                                            withString:@"\n    "
                                               options:(NSStringCompareOptions)0
                                                 range:(NSRange){0,subDescription.length - 1}];
        }
        [description appendString:subDescription];
    }];

    [description appendString:@"}"];

    return description;
}
LX_DIAGNOSTIC_POP

@end

NS_ASSUME_NONNULL_END
