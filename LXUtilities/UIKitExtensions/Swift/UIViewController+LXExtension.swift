//
//  UIViewController+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

protocol InstantiateFromStoryboardSupporting: class {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension InstantiateFromStoryboardSupporting {
    static var storyboardIdentifier: String { return String(describing: Self.self) }
}

extension Swifty where Base: UIViewController & InstantiateFromStoryboardSupporting {
    static func instantiateFromStoryboard() -> Base {
        return UIStoryboard(name: Base.storyboardName, bundle: nil).instantiateViewController(withIdentifier: Base.storyboardIdentifier) as! Base
    }
}

extension Swifty where Base: UIViewController {

    var navigationBar: UINavigationBar? {
        return base.navigationController?.navigationBar
    }

    /// 获取当前导航栈中的上一级视图控制器。
    var previousViewControllerInNavigationStack: UIViewController? {
        guard let viewControllers = base.navigationController?.viewControllers else { return nil }
        guard let index = viewControllers.index(of: base), index > 0 else { return nil }
        return viewControllers[index - 1]
    }

    /// 获取当前视图控制器层级中的顶层可见视图控制器。
    var visibleViewControllerInHierarchy: UIViewController? {
        if let presentedViewController = base.presentedViewController {
            return presentedViewController.lx.visibleViewControllerInHierarchy
        }

        if let navigationController = base as? UINavigationController {
            return navigationController.visibleViewController?.lx.visibleViewControllerInHierarchy
        }

        if let tabBarController = base as? UITabBarController {
            return tabBarController.selectedViewController?.lx.visibleViewControllerInHierarchy
        }

        if let splitViewController = base as? UISplitViewController {
            return splitViewController.viewControllers.first?.lx.visibleViewControllerInHierarchy
        }

        if base.isViewLoaded && base.view.window != nil {
            return base
        } else {
            lx.printLog("visible view controller not exist in hierarchy.");
            return nil
        }
    }
}

/*
 class ViewController: UIViewController, SegueHandler {

	enum SegueIdentifier: String {
        case segueA
        case segueB
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .segueA:
            print("Segue A.")
        case .segueB:
            print("Segue B.")
        }
	}

	@IBAction func buttonADidTap(_ sender: AnyObject) {
        performSegue(with: .segueA, sender: self)
	}

	@IBAction func buttonBDidTap(_ sender: AnyObject) {
        performSegue(with: .segueB, sender: self)
	}
 }
 */
protocol SegueHandler {
    associatedtype SegueIdentifier: RawRepresentable
}

extension Swifty where Base: UIViewController, Base: SegueHandler, Base.SegueIdentifier.RawValue == String {

    func performSegue(with identifier: Base.SegueIdentifier, sender: Any?) {
        base.performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }

    func segueIdentifier(for segue: UIStoryboardSegue) -> Base.SegueIdentifier {
        guard let identifier = segue.identifier else {
            fatalError("Segue without identifier.")
        }
        guard let segueIdentifier = Base.SegueIdentifier(rawValue: identifier) else {
            fatalError("Invalid segue identifier \(identifier).")
        }
        return segueIdentifier
    }
}
