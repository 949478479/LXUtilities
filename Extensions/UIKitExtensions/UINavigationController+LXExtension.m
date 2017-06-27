//
//  UINavigationController+LXExtension.m
//
//  Created by 从今以后 on 2017/6/27.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import "UINavigationController+LXExtension.h"

@implementation UINavigationController (LXExtension)

- (void)_lx_performCompletion:(void (^)(BOOL finished))completion
{
	if (self.transitionCoordinator) {
		[self.transitionCoordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
			!completion ?: completion(!context.isCancelled);
		}];
	} else {
		!completion ?: completion(YES);
	}
}

- (void)lx_pushViewController:(UIViewController *)viewController
					 animated:(BOOL)animated
				   completion:(void (^)(BOOL finished))completion
{
	[self pushViewController:viewController animated:animated];
	[self _lx_performCompletion:completion];
}

- (UIViewController *)lx_popViewControllerAnimated:(BOOL)animated
										completion:(void (^)(BOOL finished))completion
{
	UIViewController *vc = [self popViewControllerAnimated:animated];
	[self _lx_performCompletion:completion];
	return vc;
}

- (NSArray<UIViewController *> *)lx_popToViewController:(UIViewController *)viewController
											   animated:(BOOL)animated
											 completion:(void (^)(BOOL finished))completion
{
	NSArray *vcs = [self popToViewController:viewController animated:animated];
	[self _lx_performCompletion:completion];
	return vcs;
}


- (NSArray<UIViewController *> *)lx_popToRootViewControllerAnimated:(BOOL)animated 
														 completion:(void (^)(BOOL))completion
{
	NSArray *vcs = [self popToRootViewControllerAnimated:animated];
	[self _lx_performCompletion:completion];
	return vcs;
}

@end
