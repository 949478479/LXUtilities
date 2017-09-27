//
//  UIViewController+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UIViewController {

    var navigationBar: UINavigationBar? {
        return base.navigationController?.navigationBar
    }

    static func instantiate(withStoryboardName name: String, identifier: String? = nil) -> Base {
        let sb = UIStoryboard(name: name, bundle: nil)
        if let identifier = identifier {
            return sb.instantiateViewController(withIdentifier: identifier) as! Base
        }
        return sb.instantiateViewController(withIdentifier: String(describing: Base.self)) as! Base
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
