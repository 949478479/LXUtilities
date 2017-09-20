//
//  LXKeyboardSpacingView.m
//
//  Created by 从今以后 on 15/10/8.
//  Copyright © 2015年 从今以后. All rights reserved.
//

#import "UIScreen+LXExtension.h"
#import "LXKeyboardSpacingView.h"
#import "NSNotificationCenter+LXExtension.h"

@interface LXKeyboardSpacingView ()
@property (nonatomic, unsafe_unretained) id keyboardObserver;
@end

@implementation LXKeyboardSpacingView

- (void)dealloc {
	if (_keyboardObserver) {
		[[NSNotificationCenter defaultCenter] removeObserver:_keyboardObserver];
	}
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
	if (newSuperview) {
		if (self.keyboardObserver) {
			[[NSNotificationCenter defaultCenter] removeObserver:self.keyboardObserver];
		}

		__weak typeof(self) weakSelf = self;
		self.keyboardObserver =
		[NSNotificationCenter lx_observeKeyboardFrameChangeWithBlock:^(NSNotification *note) {
			__strong typeof(weakSelf) self = weakSelf;

			CGRect keyboardEndFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
			CGFloat keyboardOriginY = CGRectGetMinY(keyboardEndFrame);
			CGFloat keyboardHeight  = CGRectGetHeight(keyboardEndFrame);

			CGFloat constant = (keyboardOriginY < [UIScreen lx_size].height) ? keyboardHeight : 0;
			self.heightConstraint.constant = constant;

			NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
			[UIView animateWithDuration:duration animations:^{
				[self.superview layoutIfNeeded];
			}];
		}];
	}
}

@end
