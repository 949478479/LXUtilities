//
//  NSAttributedString+LXExtension.h
//
//  Created by 从今以后 on 15/10/10.
//  Copyright © 2015年 从今以后. All rights reserved.
//

@import UIKit;
#import "LXMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (LXExtension)

- (CGSize)lx_sizeWithBoundingSize:(CGSize)size;

@end

LX_OVERLOADABLE
NS_INLINE NSRange LXMaxRange(NSAttributedString *string) {
    return (NSRange){0,string.length};
}

NS_ASSUME_NONNULL_END
