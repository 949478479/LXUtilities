//
//  LXUtilities.m
//
//  Created by 从今以后 on 16/10/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "LXUtilities.h"

int objc_sync_enter(id obj);
int objc_sync_exit(id obj);

void synchronized(id obj, void (^block)(void)) {
    objc_sync_enter(obj);
    block();
    objc_sync_exit(obj);
}
