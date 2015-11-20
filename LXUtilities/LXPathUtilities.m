//
//  LXPathUtilities.m
//
//  Created by 从今以后 on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "LXPathUtilities.h"

NS_ASSUME_NONNULL_BEGIN

NSString * LXDocumentDirectory()
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

NSString * LXDocumentDirectoryByAppendingPathComponent(NSString *pathComponent)
{
    return [LXDocumentDirectory() stringByAppendingPathComponent:pathComponent];
}

NSString * LXLibraryDirectory()
{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
}

NSString * LXLibraryDirectoryByAppendingPathComponent(NSString *pathComponent)
{
    return [LXLibraryDirectory() stringByAppendingPathComponent:pathComponent];
}

NSString * LXCachesDirectory()
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}

NSString * LXCachesDirectoryByAppendingPathComponent(NSString *pathComponent)
{
    return [LXCachesDirectory() stringByAppendingPathComponent:pathComponent];
}

NS_ASSUME_NONNULL_END
