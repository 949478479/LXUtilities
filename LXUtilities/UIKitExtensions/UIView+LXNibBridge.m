//
//  UIView+LXNibBridge.m
//
//  Created by 从今以后 on 2017/12/5.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import "UIView+LXNibBridge.h"
#import "UIView+LXExtension.h"
#import "NSObject+LXExtension.h"

@interface UIView (LXNibBridge)
- (id)lx_awakeAfterUsingCoder:(NSCoder *)aDecoder NS_REPLACES_RECEIVER;
@end

@implementation UIView (LXNibBridge)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self lx_exchangeOriginalSEL:@selector(awakeAfterUsingCoder:) swizzledSEL:@selector(lx_awakeAfterUsingCoder:)];
    });
}

- (id)lx_awakeAfterUsingCoder:(NSCoder *)aDecoder
{
	// 此方法只会在主线程调用
	// 如果多个采纳 LXNibBridge 协议的视图构成了层级关系，构建顺序是先构建子视图再构建父视图
	static BOOL _shouldReplace = YES;
    if (_shouldReplace && [[self class] conformsToProtocol:@protocol(LXNibBridge)]) {
        _shouldReplace = NO;
        UIView *realView = [self lx_instantiateRealViewFromPlaceholder:self];
        _shouldReplace = YES;
        return realView;
    }
    return self;
}

- (UIView *)lx_instantiateRealViewFromPlaceholder:(UIView *)placeholderView
{
    UIView *realView = [[placeholderView class] lx_instantiateFromNib];

    realView.tag = placeholderView.tag;
    realView.alpha = placeholderView.alpha;
    realView.frame = placeholderView.frame;
    realView.bounds = placeholderView.bounds;
    realView.hidden = placeholderView.hidden;
    realView.opaque = placeholderView.opaque;
    realView.tintColor = placeholderView.tintColor;
    realView.contentMode = placeholderView.contentMode;
    realView.clipsToBounds = placeholderView.clipsToBounds;
    realView.autoresizingMask = placeholderView.autoresizingMask;
    realView.autoresizesSubviews = placeholderView.autoresizesSubviews;
	realView.multipleTouchEnabled = placeholderView.multipleTouchEnabled;
    realView.userInteractionEnabled = placeholderView.userInteractionEnabled;
    realView.clearsContextBeforeDrawing = placeholderView.clearsContextBeforeDrawing;
	realView.translatesAutoresizingMaskIntoConstraints = placeholderView.translatesAutoresizingMaskIntoConstraints;
	if (@available(iOS 8.0, *)) {
		realView.layoutMargins = placeholderView.layoutMargins;
		realView.preservesSuperviewLayoutMargins = placeholderView.preservesSuperviewLayoutMargins;
	}
	if (@available(iOS 9.0, *)) {
		realView.semanticContentAttribute = placeholderView.semanticContentAttribute;
	}
	if (@available(iOS 11.0, *)) {
		realView.directionalLayoutMargins = placeholderView.directionalLayoutMargins;
		realView.insetsLayoutMarginsFromSafeArea = placeholderView.insetsLayoutMarginsFromSafeArea;
	}

	NSUInteger countOfConstraints = placeholderView.constraints.count;

    if (countOfConstraints > 0) {

		NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:countOfConstraints];

        for (NSLayoutConstraint *constraint in placeholderView.constraints) {

            NSLayoutConstraint* newConstraint;

			// secondItem 为 nil 表示 width 或 height 约束
            if (!constraint.secondItem) {
                newConstraint =
                [NSLayoutConstraint constraintWithItem:realView
                                             attribute:constraint.firstAttribute
                                             relatedBy:constraint.relation
                                                toItem:nil
                                             attribute:constraint.secondAttribute
                                            multiplier:constraint.multiplier
                                              constant:constraint.constant];
            }
			// first item 和 second item 相同表示宽高比约束
            else if (constraint.firstItem == constraint.secondItem) {
                newConstraint =
                [NSLayoutConstraint constraintWithItem:realView
                                             attribute:constraint.firstAttribute
                                             relatedBy:constraint.relation
                                                toItem:realView
                                             attribute:constraint.secondAttribute
                                            multiplier:constraint.multiplier
                                              constant:constraint.constant];
            }

            // 若拷贝了约束，则进一步拷贝其他属性
            if (newConstraint) {
				newConstraint.priority = constraint.priority;
				newConstraint.identifier = constraint.identifier;
                newConstraint.shouldBeArchived = constraint.shouldBeArchived;
                [constraints addObject:newConstraint];
            }
        }

		[realView addConstraints:constraints];
    }

    return realView;
}

@end
