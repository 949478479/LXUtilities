//
//  LXDynamicTypeManager.m
//
//  Created by 从今以后 on 16/1/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LXDynamicTypeManager.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LXDynamicTypeManager

static NSMutableArray<void (^)(void)> *LXRegisteredBlocks;
static NSMapTable<UIView *, void (^)(void)> *LXRegisteredViewsAndBlocks;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        LXRegisteredBlocks = [NSMutableArray new];

        NSPointerFunctionsOptions keyOptions = NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality;
        NSPointerFunctionsOptions valueOptions = NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPointerPersonality;

        LXRegisteredViewsAndBlocks = [NSMapTable mapTableWithKeyOptions:keyOptions valueOptions:valueOptions];

        void (^usingBlock)(NSNotification * _Nonnull) = ^(NSNotification * _Nonnull note) {

            for (void (^block)(void) in LXRegisteredViewsAndBlocks.objectEnumerator) {
                block();
            }

            for (void (^block)(void) in LXRegisteredBlocks) {
                block();
            }
        };

        [[NSNotificationCenter defaultCenter] addObserverForName:UIContentSizeCategoryDidChangeNotification
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:usingBlock];
    });
}

+ (void)registerBlock:(void (^)(void))block
{
    [LXRegisteredBlocks addObject:block];
}

+ (void)registerView:(UIView *)view usingBlock:(void (^)(void))block
{
    [LXRegisteredViewsAndBlocks setObject:block forKey:view];
}

+ (void)removeView:(UIView *)view
{
    [LXRegisteredViewsAndBlocks removeObjectForKey:view];
}

@end

NS_ASSUME_NONNULL_END
