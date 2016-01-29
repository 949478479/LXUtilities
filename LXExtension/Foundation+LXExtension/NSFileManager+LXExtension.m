//
//  NSFileManager+LXExtension.m
//
//  Created by 从今以后 on 15/10/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NSFileManager+LXExtension.h"
#import "LXMacro.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSFileManager (LXExtension)

+ (NSString *)lx_pathToApplicationSupportDirectory
{
	NSString *applicationSupportDirectory = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
																				NSUserDomainMask,
																				YES)[0];
	BOOL isDir = NO;
	NSError *error = nil;
	NSFileManager *fileManager = [NSFileManager defaultManager];

	// Application Support 存在
	if ([fileManager fileExistsAtPath:applicationSupportDirectory
						  isDirectory:&isDir]) {
		if (isDir == NO) { // 但是个文件而不是文件夹，移除该文件
			[fileManager removeItemAtPath:applicationSupportDirectory error:&error];
			if (error != nil) {
				LXLog(error.localizedDescription);
				error = nil;
			}
		} else { // Application Support 文件夹已存在，直接返回路径
			return applicationSupportDirectory;
		}
	}

	// Application Support 不存在，创建该文件夹
	[fileManager createDirectoryAtPath:applicationSupportDirectory
		   withIntermediateDirectories:YES
							attributes:nil
								 error:&error];
	if (error != nil) {
		LXLog(error.localizedDescription);
	}

	return applicationSupportDirectory;
}

+ (uint64_t)lx_sizeOfItemAtPath:(NSString *)path
{
    NSParameterAssert(path != nil);

	if (path.length == 0) {
		return 0;
	}

    NSFileManager *fileManager   = [NSFileManager defaultManager];
    NSDictionary *itemAttributes = [fileManager attributesOfItemAtPath:path error:NULL];

    if (itemAttributes[NSFileType] != NSFileTypeDirectory) { // 文件
        return [itemAttributes[NSFileSize] unsignedLongLongValue];
    }

    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];

    uint64_t size = 0;
    while ([enumerator nextObject]) {
        itemAttributes = [enumerator fileAttributes];
        if (itemAttributes[NSFileType] == NSFileTypeRegular) {
            size += [itemAttributes[NSFileSize] unsignedLongLongValue];
        }
    }
    return size;
}

@end

NS_ASSUME_NONNULL_END
