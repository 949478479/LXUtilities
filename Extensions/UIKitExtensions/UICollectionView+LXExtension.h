//
//  UICollectionView+LXExtension.h
//
//  Created by 从今以后 on 16/8/18.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (LXExtension)

- (void)lx_dequeueReusableCellWithClass:(Class)cls forIndexPath:(NSIndexPath *)indexPath;

- (void)lx_reloadDataWithCompletion:(void (^)(void))completion;

- (nullable __kindof UICollectionView *)lx_cellForSelectedItem;

- (nullable NSArray<__kindof UICollectionView *> *)lx_cellsForSelectedItems;

@end

NS_ASSUME_NONNULL_END
