//
//  LXSheetView.m
//
//  Created by 从今以后 on 16/7/14.
//  Copyright © 2016年 从今以后. All rights reserved.
//

#import "LXSheetView.h"
#import "NSNotificationCenter+LXExtension.h"

@implementation LXSheetView
{
    id _observer;
    UIView *_sheetView;
    UIControl *_dimmingBackgroundView;
    NSLayoutConstraint *_verticalSpacingConstraint;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_observer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self init];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"-initWithCoder: has not been implemented." userInfo:nil];
    return [self init];
}

- (instancetype)init
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        _dimmingBackgroundView = [UIControl new];
        _dimmingBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        _dimmingBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        [_dimmingBackgroundView addTarget:self
                                   action:@selector(dismiss)
                         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_dimmingBackgroundView];

        _sheetView = [self sheetView];
        if (_sheetView.translatesAutoresizingMaskIntoConstraints) {
            _sheetView.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint constraintWithItem:_sheetView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:CGRectGetHeight(_sheetView.bounds)].active = YES;
        }
        [self addSubview:_sheetView];

        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *metrics = @{ @"sidePadding" : @([self sidePadding]) };
        NSDictionary *views = NSDictionaryOfVariableBindings(self, _sheetView, _dimmingBackgroundView);
        NSString *visualFormats[] = {
            @"V:|[_dimmingBackgroundView]|",
            @"H:|[_dimmingBackgroundView]|",
            @"H:|-(sidePadding)-[_sheetView]-(sidePadding)-|",
            @"V:[self][_sheetView]"
        };
        NSMutableArray *constraints = [NSMutableArray new];
        for (int i = 0; i < 4; ++i) {
            [constraints addObjectsFromArray:
             [NSLayoutConstraint constraintsWithVisualFormat:visualFormats[i]
                                                     options:0
                                                     metrics:metrics
                                                       views:views]];
            if (i == 3) {
                _verticalSpacingConstraint = constraints.lastObject;
            }
        }
        [self addConstraints:constraints];

        __weak typeof(self) weakSelf = self;
        _observer = [NSNotificationCenter lx_observeKeyboardFrameChangeWithBlock:^(NSNotification * _Nonnull note) {
            __strong typeof(weakSelf) self = weakSelf;
            if (self) {
                NSDictionary *userInfo  = note.userInfo;
                CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
                CGFloat keyboardOriginY = CGRectGetMinY(keyboardEndFrame);
                CGFloat keyboardHeight  = CGRectGetHeight(keyboardEndFrame);

                NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
                UIViewAnimationOptions curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
                
                [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                    self.bounds = ({
                        CGRect bounds = self.bounds;
                        bounds.origin.y = (keyboardOriginY < CGRectGetHeight(bounds)) ? keyboardHeight : 0;
                        bounds;
                    });
                } completion:nil];
            }
        }];
    }
    return self;
}

- (UIView *)sheetView {
    [NSException raise:NSInternalInconsistencyException
                format:@"子类必须重写 %@ 方法提供自定义视图", @(sel_getName(_cmd))];
    return nil;
}

- (CGFloat)sidePadding {
    return 8;
}

- (CGFloat)bottomPadding {
    return 8;
}

- (void)show
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];

    [keyWindow addSubview:self];

    NSDictionary *views = NSDictionaryOfVariableBindings(self);
    NSString *visualFormats[] = { @"H:|[self]|", @"V:|[self]|" };
    for (int i = 0; i < 2; ++i) {
        [keyWindow addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:visualFormats[i]
                                                 options:kNilOptions
                                                 metrics:nil
                                                   views:views]];
    }

    [self layoutIfNeeded];

    _dimmingBackgroundView.alpha = 0.0;
    _verticalSpacingConstraint.constant = -(CGRectGetHeight(_sheetView.bounds) + [self bottomPadding]);
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self layoutIfNeeded];
                         [_dimmingBackgroundView setAlpha:1.0];
                     } completion:nil];
}

- (void)dismiss
{
    _verticalSpacingConstraint.constant = 0;
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self layoutIfNeeded];
                         [_dimmingBackgroundView setAlpha:0.0];
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
