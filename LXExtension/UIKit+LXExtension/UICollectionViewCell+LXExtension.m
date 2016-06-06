//
//  UICollectionViewCell+LXExtension.m
//
//  Created by 从今以后 on 16/6/6.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UICollectionViewCell+LXExtension.h"

@implementation UICollectionViewCell (LXExtension)

+ (instancetype)lx_cellWithCollectionView:(UICollectionView *)collectionView
                             forIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class)
                                                     forIndexPath:indexPath];
}

@end
