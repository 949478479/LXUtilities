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

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.hidden = YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
	if (newSuperview) {
		__weak typeof(self) weakSelf = self;
		self.keyboardObserver =
		[NSNotificationCenter lx_observeKeyboardFrameChangeWithBlock:^(NSNotification *note) {
			__strong typeof(weakSelf) self = weakSelf;

			CGRect keyboardEndFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
			CGFloat keyboardOriginY = CGRectGetMinY(keyboardEndFrame);
			CGFloat keyboardHeight  = CGRectGetHeight(keyboardEndFrame);

			CGFloat constant = (keyboardOriginY < [UIScreen lx_size].height) ? keyboardHeight : self.heightConstraintConstant;
			self.heightConstraint.constant = constant;

			NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
			[UIView animateWithDuration:duration animations:^{
				[self.superview layoutIfNeeded];
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
