//
//  UINavigationController+LXExtension.h
//
//  Created by 从今以后 on 2017/6/27.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (LXExtension)

- (void)lx_pushViewController:(UIViewController *)viewController
					 animated:(BOOL)animated
				   completion:(nullable void (^)(BOOL finished))completion;

- (nullable UIViewController *)lx_popViewControllerAnimated:(BOOL)animated
												 completion:(void (^)(BOOL finished))completion;

- (nullable NSArray<UIViewController *> *)lx_popToViewController:(UIViewController *)viewController
														animated:(BOOL)animated
													  completion:(nullable void (^)(BOOL finished))completion;

- (nullable NSArray<UIViewController *> *)lx_popToRootViewControllerAnimated:(BOOL)animated
																  completion:(nullable void (^)(BOOL finished))completion;
@end

NS_ASSUME_NONNULL_END
