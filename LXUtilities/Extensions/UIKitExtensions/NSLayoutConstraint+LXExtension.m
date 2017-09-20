#import "NSLayoutConstraint+LXExtension.h"

@implementation NSLayoutConstraint (LXExtension)

- (instancetype)lx_updateMultiplier:(CGFloat)multiplier
{
	NSLayoutConstraint *newConstraint =
 [NSLayoutConstraint constraintWithItem:self.firstItem
							  attribute:self.firstAttribute
							  relatedBy:self.relation
								 toItem:self.secondItem
							  attribute:self.secondAttribute
							 multiplier:multiplier
							   constant:self.constant];

	newConstraint.priority = self.priority;
	newConstraint.identifier = self.identifier;
	newConstraint.shouldBeArchived = self.shouldBeArchived;

	newConstraint.active = YES;
	self.active = NO;

	return newConstraint;
}

@end
