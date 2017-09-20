//
//  UITableView+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/19.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

protocol Reusable: class {
	static var reuseIdentifier: String { get }
	static var nib: UINib? { get }
}

extension Reusable {
	static var reuseIdentifier: String { return String(describing: Self.self) }
	static var nib: UINib? { return nil }
}

extension UITableViewCell: Reusable {}

extension UITableView {

	func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
		if let nib = T.nib {
			register(nib, forCellReuseIdentifier: T.reuseIdentifier)
		} else {
			register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
		}
	}

	// e.g. tableView.dequeueReusableCell(for: indexPath) as CustomCell
	func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
		return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
	}

	func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
		if let nib = T.nib {
			register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
		} else {
			register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
		}
	}

	func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: Reusable {
		return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
	}
}
