//
//  UIScreen+LXExtension.h
//
//  Created by 从今以后 on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (LXExtension)

/// 获取 `mainScreen` 的 `size`。
+ (CGSize)lx_size NS_SWIFT_UNAVAILABLE("Use lx.size instead.");

/// 获取 `mainScreen` 的 `scale`。
+ (CGFloat)lx_scale NS_SWIFT_UNAVAILABLE("Use lx.scale instead.");

@end

NS_ASSUME_NONNULL_END
