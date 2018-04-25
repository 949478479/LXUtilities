//
//  UINavigationController+LXExtension.swift
//
//  Created by 从今以后 on 2018/4/16.
//  Copyright © 2018年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UINavigationController {

	func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping ((Bool)-> Void)) {
		base.pushViewController(viewController, animated: animated)
		performCompletion(completion)
	}

	@discardableResult
	func popViewController(animated: Bool, completion: @escaping ((Bool)-> Void)) -> UIViewController? {
		defer { performCompletion(completion) }
		return base.popViewController(animated: animated)
	}

	@discardableResult
	func popToViewController(
		_ viewController: UIViewController,
		animated: Bool,
		completion: @escaping ((Bool)-> Void))
		-> [UIViewController]?
	{
		defer { performCompletion(completion) }
		return base.popToViewController(viewController, animated: animated)
	}

	@discardableResult
	func popToRootViewController(animated: Bool, completion: @escaping ((Bool) -> Void)) -> [UIViewController]? {
		defer { performCompletion(completion) }
		return base.popToRootViewController(animated: animated)
	}
	
	private func performCompletion(_ completion: @escaping ((Bool) -> Void)) {
		if let transitionCoordinator = base.transitionCoordinator {
			transitionCoordinator.animate(alongsideTransition: nil) { (context) in
				completion(!context.isCancelled)
			}
		} else {
			completion(true)
		}
	}
}
