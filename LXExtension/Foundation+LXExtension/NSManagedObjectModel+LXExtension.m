//
//  NSManagedObjectModel+LXExtension.m
//
//  Created by 从今以后 on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSManagedObjectModel+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSManagedObjectModel (LXExtension)

+ (NSArray<NSString *> *)lx_modelPathsForModelName:(NSString *)modelName
{
	// 各版本的 .xcdatamodel 文件均位于应用程序包的 .momd 文件夹内，扩展名 .xcdatamodel 会变为 .mom
	return [[NSBundle mainBundle] pathsForResourcesOfType:@"mom"
											  inDirectory:[modelName stringByAppendingPathExtension:@"momd"]];
}

+ (NSArray<NSString *> *)lx_allModelPaths
{
	NSMutableArray *modelPaths = [NSMutableArray new];
	{
        NSArray  *paths          = nil;
        NSString *modelDirectory = nil;
        NSBundle *mainBundle     = [NSBundle mainBundle];
        NSArray  *momdArray      = [mainBundle pathsForResourcesOfType:@"momd" inDirectory:nil];

		for (NSString *momdPath in momdArray) {
			modelDirectory = [momdPath lastPathComponent];
			paths = [mainBundle pathsForResourcesOfType:@"mom" inDirectory:modelDirectory];
			[modelPaths addObjectsFromArray:paths];
		}
	}
	return modelPaths;
}

- (NSString *)lx_modelName
{
    NSURL *modelURL = nil;
	NSManagedObjectModel *model = nil;
    NSArray *modelPaths = [[self class] lx_allModelPaths];

	for (NSString *modelPath in modelPaths) {
		modelURL = [NSURL fileURLWithPath:modelPath];
		model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
		if ([model isEqual:self]) {
			return modelURL.lastPathComponent.stringByDeletingPathExtension;
		}
	}

	return nil;
}

@end

NS_ASSUME_NONNULL_END
