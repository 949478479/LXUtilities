//
//  LXAlertView.m
//
//  Created by 从今以后 on 16/2/21.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "LXAlertView.h"

@implementation LXAlertView {
    UIView *_alertView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];

        [self addGestureRecognizer:
         [[UITapGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(_tapGestureHandler:)]];

        _alertView = [self alertView];
		if (_alertView.translatesAutoresizingMaskIntoConstraints) {
			_alertView.translatesAutoresizingMaskIntoConstraints = NO;
			[NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetWidth(_alertView.bounds)].active = YES;
			[NSLayoutConstraint constraintWithItem:_alertView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetHeight(_alertView.bounds)].active = YES;
		}
        [self addSubview:_alertView];

        UIOffset offset = [self alertViewOffset];
        CGFloat constants[] = { offset.horizontal, offset.vertical };
        NSLayoutAttribute attributes[] = { NSLayoutAttributeCenterX, NSLayoutAttributeCenterY };
		for (int i = 0; i < 2; ++i) {
			[NSLayoutConstraint constraintWithItem:_alertView
										 attribute:attributes[i]
										 relatedBy:NSLayoutRelationEqual
											toItem:self
										 attribute:attributes[i]
										multiplier:1.0
										  constant:constants[i]].active = YES;
        }
    }
    return self;
}

- (UIView *)alertView {
    [NSException raise:NSInternalInconsistencyException format:@"子类必须重写 %@ 方法提供自定义视图", @(sel_getName(_cmd))];
    return nil;
}

- (UIOffset)alertViewOffset {
    return UIOffsetZero;
}

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];

    NSDictionary *views = NSDictionaryOfVariableBindings(self);
    NSString *visualFormats[] = { @"H:|[self]|", @"V:|[self]|" };
	for (int i = 0; i < 2; ++i) {
		[NSLayoutConstraint activateConstraints:
		 [NSLayoutConstraint constraintsWithVisualFormat:visualFormats[i]
												 options:kNilOptions
												 metrics:nil
												   views:views]];
	}

    self.alpha = 0.0;
    _alertView.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.alpha = 1.0;
		_alertView.transform = CGAffineTransformIdentity;
	} completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)_tapGestureHandler:(UITapGestureRecognizer *)gr {
    CGPoint loation = [gr locationInView:_alertView];
    if (![_alertView pointInside:loation withEvent:nil]) {
        if (self.shouldDismissOnTouchOutside) {
            [self dismiss];
        }
    }
}

@end
