//
//  UIViewController+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/20.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

protocol SegueHandler {
	associatedtype SegueIdentifier: RawRepresentable
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
extension SegueHandler where Self: UIViewController, SegueIdentifier.RawValue == String {

	func performSegue(with identifier: SegueIdentifier, sender: Any?) {
		performSegue(withIdentifier: identifier.rawValue, sender: sender)
	}

	func segueIdentifier(for segue: UIStoryboardSegue) -> SegueIdentifier {
		guard let identifier = segue.identifier else {
			fatalError("Segue without identifier.")
		}
		guard let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
			fatalError("Invalid segue identifier \(identifier).")
		}
		return segueIdentifier
	}
}
