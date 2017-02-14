//
//  UICollectionView+LXExtension.h
//  XWZUserClient
//
//  Created by 从今以后 on 16/8/18.
//  Copyright © 2016年 创意时代. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (LXExtension)

@property (nullable, nonatomic, readonly) __kindof UICollectionView *lx_cellForSelectedItem;

@property (nullable, nonatomic, readonly) NSArray<__kindof UICollectionView *> *lx_cellsForSelectedItems;

@end
