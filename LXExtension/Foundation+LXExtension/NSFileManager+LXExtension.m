//
//  NSFileManager+LXExtension.m
//
//  Created by 从今以后 on 15/10/13.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSFileManager+LXExtension.h"
#import "LXMacro.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSFileManager (LXExtension)

#pragma mark - 路径 & URL -

+ (NSString *)lx_pathForDocumentDirectory
{
	return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)lx_URLForDocumentDirectory
{
	return [NSURL fileURLWithPath:[self lx_pathForDocumentDirectory]];
}

+ (NSString *)lx_pathForLibraryDirectory
{
	return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)lx_URLForLibraryDirectory
{
	return [NSURL fileURLWithPath:[self lx_pathForLibraryDirectory]];
}

+ (NSString *)lx_pathForCachesDirectory
{
	return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

+ (NSURL *)lx_URLForCachesDirectory
{
	return [NSURL fileURLWithPath:[self lx_pathForCachesDirectory]];
}

+ (NSString *)lx_pathForApplicationSupportDirectory
{
	NSString *directoryPath = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
																  NSUserDomainMask,
																  YES)[0];
	BOOL isDir = NO;
	NSError *error = nil;
	NSFileManager *fileManager = [NSFileManager defaultManager];

	// Application Support 存在
	if ([fileManager fileExistsAtPath:directoryPath
						  isDirectory:&isDir]) {
		if (isDir == NO) { // Application Support 是个文件而不是文件夹，移除该文件
			[fileManager removeItemAtPath:directoryPath error:&error];
			if (error != nil) {
				LXLog(error.localizedDescription);
				error = nil;
			}
		} else { // Application Support 文件夹已存在，直接返回路径
			return directoryPath;
		}
	}

	// Application Support 不存在，创建该文件夹
	[fileManager createDirectoryAtPath:directoryPath
		   withIntermediateDirectories:YES
							attributes:nil
								 error:&error];
	if (error != nil) {
		LXLog(error.localizedDescription);
	}

	return directoryPath;
}

+ (NSURL *)lx_URLForApplicationSupportDirectory
{
	return [NSURL fileURLWithPath:[self lx_pathForApplicationSupportDirectory]];
}

#pragma mark - 文件 -

+ (uint64_t)lx_sizeOfItemAtPath:(NSString *)path
{
    NSParameterAssert(path != nil);

	if (path.length == 0) {
		return 0;
	}

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *itemAttributes = [fileManager attributesOfItemAtPath:path error:NULL];

    if (itemAttributes[NSFileType] == NSFileTypeRegular) { // 文件
        return [itemAttributes[NSFileSize] unsignedLongLongValue];
	}
	else if (itemAttributes[NSFileType] == NSFileTypeDirectory) { // 文件夹
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
	return 0; // 其他
}

#pragma mark - 文件校验

+ (nullable NSString *)lx_MD5ForFileAtPath:(NSString *)path
{
	NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
	if (!handle) {
		return nil;
	}

	CC_MD5_CTX md5;
	CC_MD5_Init(&md5);

	while (1) {
		NSData *fileData = [handle readDataOfLength:1024];
		if (fileData.length == 0) {
			break;
		}
		CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
	}

	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final(digest, &md5);

	NSString *MD5String = [NSString stringWithFormat:
						   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				   digest[0], digest[1],
				   digest[2], digest[3],
				   digest[4], digest[5],
				   digest[6], digest[7],
				   digest[8], digest[9],
				   digest[10], digest[11],
				   digest[12], digest[13],
				   digest[14], digest[15]];

	return MD5String;
}

@end

NS_ASSUME_NONNULL_END
