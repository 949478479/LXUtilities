//
//  NSFileManager+LXExtension.h
//
//  Created by 从今以后 on 15/10/13.
//  Copyright © 2015年 apple. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (LXExtension)

/// Application Support 文件夹路径，若尚未存在则进行创建。
+ (NSString *)lx_pathToApplicationSupportDirectory;

/// 计算文件或目录所占字节数。
+ (uint64_t)lx_sizeOfItemAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
