//
//  LXMigrationManager.m
//
//  Created by 从今以后 on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

@import CoreData;
#import "LXMacro.h"
#import "LXMigrationManager.h"
#import "NSManagedObjectModel+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXMigrationManager ()
@property (nonatomic) NSMutableArray<NSString *> *modelPaths;
@end

@implementation LXMigrationManager

- (BOOL)progressivelyMigrateStoreFromURL:(NSURL *)sourceStoreURL
							toFinalModel:(NSManagedObjectModel *)finalModel
								   error:(NSError **)error
{
	NSDictionary *sourceMetadata =
	[NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType
															   URL:sourceStoreURL
														   options:nil
															 error:error];
	if (!sourceMetadata) {
		return NO;
	}

	// 检查当前版本和最终版本是否兼容，若不兼容则需要迁移
	if ([finalModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata]) {
		if (error != NULL) {
			*error = nil;
		}
		return YES;
	}

	NSMappingModel *mappingModel = nil;
	NSManagedObjectModel *destinationModel = nil;
	NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:nil
																	forStoreMetadata:sourceMetadata];
	if (![self __getDestinationModel:&destinationModel
						mappingModel:&mappingModel
					  forSourceModel:sourceModel]) {

		// 未找到对应的映射文件，尝试直接根据最终模型推断一个映射文件
		mappingModel = [NSMappingModel inferredMappingModelForSourceModel:sourceModel
														 destinationModel:finalModel
																	error:error];
		if (mappingModel == nil) {
			return NO;
		}

		destinationModel = finalModel;
	}

	// 迁移前先创建临时存储路径
	NSURL *destinationStoreURL = [self __destinationStoreURLWithSourceStoreURL:sourceStoreURL];
	NSMigrationManager *manager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel
																 destinationModel:destinationModel];
	// 执行迁移
	if (![manager migrateStoreFromURL:sourceStoreURL
								 type:NSSQLiteStoreType
							  options:nil
					 withMappingModel:mappingModel
					 toDestinationURL:destinationStoreURL
					  destinationType:NSSQLiteStoreType
				   destinationOptions:nil
								error:error]) {
		return NO;
	}

	if (![self __replaceSourceStoreAtURL:sourceStoreURL
			   withDestinationStoreAtURL:destinationStoreURL
								   error:error]) {
		return NO;
	}

	// 已经迁移到最终版本，迁移结束
	if ([destinationModel isEqual:finalModel]) {
		_modelPaths = nil;
		return YES;
	}

	// 只往后迁移了一个版本，继续递归
	return [self progressivelyMigrateStoreFromURL:sourceStoreURL
									 toFinalModel:finalModel
											error:error];
}

- (NSMutableArray<NSString *> *)modelPaths
{
	if (!_modelPaths) {
		_modelPaths = (NSMutableArray *)[NSManagedObjectModel lx_allModelPaths];
	}
	return _modelPaths;
}

- (BOOL)__getDestinationModel:(NSManagedObjectModel * _Nonnull *)destinationModel
				 mappingModel:(NSMappingModel * _Nonnull *)mappingModel
			   forSourceModel:(NSManagedObjectModel *)sourceModel
{
	*mappingModel = nil;
	*destinationModel = nil;

	if (_modelPaths.count == 0) {
		return NO;
	}

	__block NSUInteger index = NSNotFound;
	__block NSMappingModel *mapping = nil;
	__block NSManagedObjectModel *model = nil;

	[_modelPaths enumerateObjectsUsingBlock:^(NSString * _Nonnull modelPath,
											  NSUInteger idx,
											  BOOL * _Nonnull stop) {

		// 根据应用程序包中的某个 .mom 文件（即 .xcdatamodeld 文件）创建 NSManagedObjectModel
		model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];

		// 根据当前模型和目标模型在应用程序包内查找对应的迁移映射文件
		mapping = [NSMappingModel mappingModelFromBundles:nil
										   forSourceModel:sourceModel
										 destinationModel:model];
		if (mapping != nil) {
			index = idx;
			*stop = YES;
		}
	}];

	if (index != NSNotFound) {
		*mappingModel = mapping;
		*destinationModel = model;
		[_modelPaths removeObjectAtIndex:index]; // 移除该路径避免下次递归时重复判断
		return YES;
	}

	return NO;
}

- (NSURL *)__destinationStoreURLWithSourceStoreURL:(NSURL *)sourceStoreURL
{
	// xxx.sqlite => xxx_temp.sqlite
	NSString *absoluteString = sourceStoreURL.absoluteString;
	NSRange range = [absoluteString rangeOfString:@"." options:NSBackwardsSearch];
	absoluteString = [absoluteString stringByReplacingCharactersInRange:range withString:@"_temp."];
	return [NSURL URLWithString:absoluteString];
}

- (BOOL)__replaceSourceStoreAtURL:(NSURL *)sourceStoreURL
		withDestinationStoreAtURL:(NSURL *)destinationStoreURL
							error:(NSError **)error
{
	NSFileManager *fileManager = [NSFileManager defaultManager];

	// 移除旧版数据库
	if (![fileManager removeItemAtURL:sourceStoreURL error:error]) {
		return NO;
	}

	// 将新版数据库改名为旧版数据库
	if (![fileManager moveItemAtURL:destinationStoreURL toURL:sourceStoreURL error:error]) {
		return NO;
	}

	return YES;
}

@end

NS_ASSUME_NONNULL_END
