//
//  UICollectionView+LXExtension.m
//
//  Created by 从今以后 on 16/8/18.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UICollectionView+LXExtension.h"

@implementation UICollectionView (LXExtension)

- (void)lx_dequeueReusableCellWithClass:(Class)cls forIndexPath:(NSIndexPath *)indexPath {
	[self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cls) forIndexPath:indexPath];
}

- (void)lx_reloadDataWithCompletion:(void (^)(void))completion
{
	[UIView animateWithDuration:0 animations:^{
		[self reloadData];
	} completion:^(BOOL finished) {
		completion();
	}];
}

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
