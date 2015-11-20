//
//  LXPathUtilities.h
//
//  Created by 从今以后 on 15/11/20.
//  Copyright © 2015年 apple. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

NSString * LXDocumentDirectory();
NSString * LXDocumentDirectoryByAppendingPathComponent(NSString *pathComponent);

NSString * LXLibraryDirectory();
NSString * LXLibraryDirectoryByAppendingPathComponent(NSString *pathComponent);

NSString * LXCachesDirectory();
NSString * LXCachesDirectoryByAppendingPathComponent(NSString *pathComponent);

NS_ASSUME_NONNULL_END
