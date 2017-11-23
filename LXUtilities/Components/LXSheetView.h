//
//  LXSheetView.h
//
//  Created by 从今以后 on 16/7/14.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXSheetView : UIView

- (instancetype)init NS_DESIGNATED_INITIALIZER;

/// 子类返回自定义视图
- (UIView *)sheetView;

/// 子类返回 sheet view 距离屏幕左右边缘的距离，默认为 8
- (CGFloat)sidePadding;

/// 子类返回 sheet view 距离屏幕底部的距离，默认为 8
- (CGFloat)bottomPadding;

/// 呈现
- (void)show;

/// 移除
- (IBAction)dismiss;

@end

NS_ASSUME_NONNULL_END
