//
//  NSArray+LXExtension.m
//
//  Created by 从今以后 on 15/10/4.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@protocol LXDescriptionProtocol;
#import "LXMacro.h"
#import "NSArray+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSArray (LXExtension)

#pragma mark - 常用方法 -

+ (nullable instancetype)lx_arrayWithResourcePath:(NSString *)path
{
    NSParameterAssert(path.length > 0);

    NSString *filePath = [NSBundle.mainBundle pathForResource:path ofType:nil];

    return [NSArray arrayWithContentsOfFile:filePath];
}

#pragma mark - 函数式便捷方法 -

- (instancetype)lx_map:(id _Nullable (^)(id _Nonnull, BOOL * _Nonnull))map
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];

    if (self.count == 0) return array;

    BOOL stop;
    for (id obj in self) {
        id result = map(obj, &stop);
        if (result) [array addObject:result];
        if (stop) return array;
    }

    return array; // 出于性能考虑就不 copy 了。
}

- (instancetype)lx_filter:(BOOL (^)(id _Nonnull))filter
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];

    if (self.count == 0) return array;

    for (id obj in self) {
        if (filter(obj)) [array addObject:obj];
    }
    
    return array; // 出于性能考虑就不 copy 了。
}

#pragma mark - 打印对齐 -

LX_DIAGNOSTIC_PUSH_IGNORED(-Wat-protocol)
- (NSString *)descriptionWithLocale:(nullable id)locale
{
    NSMutableString *description = [NSMutableString stringWithString:@"(\n"];

    for (id obj in self) {
        NSMutableString *subDescription = [NSMutableString stringWithFormat:@"    %@,\n", obj];
        if ([obj isKindOfClass:NSArray.self] ||
            [obj isKindOfClass:NSDictionary.self] ||
            [obj conformsToProtocol:@protocol(LXDescriptionProtocol)]) {
            [subDescription replaceOccurrencesOfString:@"\n"
                                            withString:@"\n    "
                                               options:(NSStringCompareOptions)0
                                                 range:(NSRange){0,subDescription.length - 1}];
        }
        [description appendString:subDescription];
    }

    [description appendString:@")"];

    return description;
}
LX_DIAGNOSTIC_POP

@end

NS_ASSUME_NONNULL_END
