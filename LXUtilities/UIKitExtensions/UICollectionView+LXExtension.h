//
//  UICollectionView+LXExtension.h
//
//  Created by 从今以后 on 16/8/18.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (LXExtension)

- (void)lx_reloadDataWithCompletion:(void (^)(void))completion;

- (nullable __kindof UICollectionView *)lx_cellForSelectedItem NS_SWIFT_UNAVAILABLE("User lx.cellForSelectedItem() instead.");
- (nullable NSArray<__kindof UICollectionView *> *)lx_visibleCellsForSelectedItems NS_SWIFT_UNAVAILABLE("User lx.visibleCellsForSelectedItems() instead.");

@end

NS_ASSUME_NONNULL_END
