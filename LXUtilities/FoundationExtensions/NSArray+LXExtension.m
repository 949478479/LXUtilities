//
//  NSArray+LXExtension.m
//
//  Created by 从今以后 on 15/10/4.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@protocol LXDescriptionProtocol;
#import "NSArray+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSArray (LXExtension)

#pragma mark - 实例化方法 -

+ (nullable NSArray *)lx_arrayWithResourcePath:(NSString *)path
{
    return [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
}

#pragma mark - 函数式便捷方法 -

- (NSMutableArray *)lx_map:(id _Nullable (^)(__unsafe_unretained id _Nonnull, NSUInteger))map
{
	NSUInteger count = self.count;

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];

	if (count == 0) {
		return array;
	}

	NSUInteger idx = 0;
    for (id obj in self) {
        id result = map(obj, idx++);
		if (result) {
			[array addObject:result];
		}
    }

    return array;
}

- (NSMutableArray *)lx_filter:(BOOL (^)(__unsafe_unretained id _Nonnull, NSUInteger idx))filter
{
	NSUInteger count = self.count;

	NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];

	if (count == 0) {
		return array;
	}

	NSUInteger idx = 0;
	for (id obj in self) {
		if (filter(obj, idx++)) {
			[array addObject:obj];
		}
	}

	return array;
}

#pragma mark - 其他

- (BOOL)lx_hasElement
{
    return self.count > 0;
}

- (nullable NSString *)lx_JSON
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:NULL];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - 打印对齐

#ifdef DEBUG

- (NSString *)descriptionWithLocale:(nullable id)locale
{
    NSMutableString *description = [NSMutableString stringWithString:@"(\n"];

    for (__strong id obj in self) {
        if ([obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"\"%@\"", obj];
        }
        
        NSMutableString *subDescription = [NSMutableString stringWithFormat:@"    %@,\n", obj];

        if ([obj isKindOfClass:[NSArray class]] ||
            [obj isKindOfClass:[NSDictionary class]] ||
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wat-protocol"
            [obj conformsToProtocol:@protocol(LXDescriptionProtocol)])
#pragma clang diagnostic pop
        {
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

- (NSString *)description {
    return [self descriptionWithLocale:nil];
}

- (NSString *)debugDescription {
    return [self descriptionWithLocale:nil];
}

#endif

@end

NS_ASSUME_NONNULL_END
