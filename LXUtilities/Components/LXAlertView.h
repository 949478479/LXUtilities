//
//  LXAlertView.h
//
//  Created by 从今以后 on 16/2/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXAlertView : UIView

/// 是否允许点击蒙版 dismiss，默认 NO
@property (nonatomic) BOOL shouldDismissOnTouchOutside;

/// 子类返回自定义视图。
- (UIView *)alertView;

/// 子类返回自定义视图偏移量。
- (UIOffset)alertViewOffset;

/// 呈现。
- (void)show;

/// 移除。
- (IBAction)dismiss;

@end

NS_ASSUME_NONNULL_END
