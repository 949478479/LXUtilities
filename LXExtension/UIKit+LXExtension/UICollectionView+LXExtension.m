//
//  UICollectionView+LXExtension.m
//  XWZUserClient
//
//  Created by 从今以后 on 16/8/18.
//  Copyright © 2016年 创意时代. All rights reserved.
//

#import "UICollectionView+LXExtension.h"

@implementation UICollectionView (LXExtension)

- (UICollectionViewCell *)lx_cellForSelectedItem
{
    NSIndexPath *indexPath = [[self indexPathsForSelectedItems] firstObject];
    if (indexPath) {
        return [self cellForItemAtIndexPath:indexPath];
    }
    return nil;
}

- (NSArray<UICollectionViewCell *> *)lx_cellsForSelectedItems
{
    NSMutableArray *cells = [NSMutableArray new];
    for (NSIndexPath *indexPath in [self indexPathsForSelectedItems]) {
        [cells addObject:[self cellForItemAtIndexPath:indexPath]];
    }
    return [cells copy];
}

@end
