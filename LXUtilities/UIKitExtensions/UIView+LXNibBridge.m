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

- (id)lx_awakeAfterUsingCoder:(NSCoder *)aDecoder {
    if ([[self class] conformsToProtocol:@protocol(LXNibBridge)] && ((UIView *)self).subviews.count == 0) {
        return [self instantiateRealViewFromPlaceholder:(UIView *)self];
    }
    return self;
}

- (UIView *)instantiateRealViewFromPlaceholder:(UIView *)placeholderView
{
    UIView *realView = [[placeholderView class] lx_instantiateFromNib];

    realView.tag = placeholderView.tag;
    realView.frame = placeholderView.frame;
    realView.bounds = placeholderView.bounds;
    realView.hidden = placeholderView.hidden;
    realView.clipsToBounds = placeholderView.clipsToBounds;
    realView.autoresizingMask = placeholderView.autoresizingMask;
    realView.userInteractionEnabled = placeholderView.userInteractionEnabled;
    realView.translatesAutoresizingMaskIntoConstraints = placeholderView.translatesAutoresizingMaskIntoConstraints;

    if (placeholderView.constraints.count > 0) {

        // We only need to copy "self" constraints (like width/height constraints)
        // from placeholder to real view
        for (NSLayoutConstraint *constraint in placeholderView.constraints) {

            NSLayoutConstraint* newConstraint;

            // "Height" or "Width" constraint
            // "self" as its first item, no second item
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
            // "Aspect ratio" constraint
            // "self" as its first AND second item
            else if ([constraint.firstItem isEqual:constraint.secondItem]) {
                newConstraint =
                [NSLayoutConstraint constraintWithItem:realView
                                             attribute:constraint.firstAttribute
                                             relatedBy:constraint.relation
                                                toItem:realView
                                             attribute:constraint.secondAttribute
                                            multiplier:constraint.multiplier
                                              constant:constraint.constant];
            }

            // Copy properties to new constraint
            if (newConstraint) {
                newConstraint.shouldBeArchived = constraint.shouldBeArchived;
                newConstraint.priority = constraint.priority;
                if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
                    newConstraint.identifier = constraint.identifier;
                }
                [realView addConstraint:newConstraint];
            }
        }
    }

    return realView;
}

@end
