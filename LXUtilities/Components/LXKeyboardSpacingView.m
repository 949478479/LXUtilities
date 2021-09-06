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
@property (nonatomic) CGFloat heightConstraintConstant;
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
        self.hidden = YES;

		__weak typeof(self) weakSelf = self;
		self.keyboardObserver =
		[NSNotificationCenter lx_observeKeyboardFrameChangeWithBlock:^(NSNotification *note) {
			__strong typeof(weakSelf) self = weakSelf;

			CGRect keyboardEndFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
			CGFloat keyboardOriginY = CGRectGetMinY(keyboardEndFrame);
			CGFloat keyboardHeight  = CGRectGetHeight(keyboardEndFrame);

            if (keyboardOriginY < [UIScreen lx_size].height) {
                self.heightConstraint.constant = keyboardHeight;
            } else {
                self.heightConstraint.constant = self.heightConstraintConstant;
            }

			NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
            NSUInteger curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];

            [UIView animateWithDuration:duration delay:0 options:curve << 16 animations:^{
                [self.superview layoutIfNeeded];
            } completion:^(BOOL finished) {

            }];
		}];
	}
}

- (void)setKeyboardObserver:(id)keyboardObserver
{
    if (_keyboardObserver == keyboardObserver) {
        return;
    }

    if (_keyboardObserver) {
        [[NSNotificationCenter defaultCenter] removeObserver:_keyboardObserver];
    }

    _keyboardObserver = keyboardObserver;
}

- (void)setHeightConstraint:(NSLayoutConstraint *)heightConstraint
{
    _heightConstraint = heightConstraint;
    self.heightConstraintConstant = heightConstraint.constant;
}

@end
