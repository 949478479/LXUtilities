//
//  UITableViewCell+LXExtension.m
//
//  Created by 从今以后 on 16/4/3.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "UITableViewCell+LXExtension.h"

@implementation UITableViewCell (LXExtension)

+ (instancetype)lx_cellWithTableView:(UITableView *)tableView
                        forIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)
                                           forIndexPath:indexPath];
}

@end
