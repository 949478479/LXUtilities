//
//  UICollectionViewCell+LXExtension.h
//
//  Created by 从今以后 on 16/6/6.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (LXExtension)

/// cell 对应的 indexPath
- (nullable NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
