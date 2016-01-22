//
//  NSFileManager+LXExtension.m
//
//  Created by 从今以后 on 15/10/13.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "NSFileManager+LXExtension.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSFileManager (LXExtension)

+ (uint64_t)lx_sizeOfItemAtPath:(NSString *)path
{
    NSParameterAssert(path != nil);
    
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
