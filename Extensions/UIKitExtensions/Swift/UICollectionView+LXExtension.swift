//
//  UICollectionView+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/19.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension UICollectionViewCell: Reusable {}

extension UICollectionView {

	func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
		if let nib = T.nib {
			register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
		} else {
			register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
		}
	}

	// e.g. collectionView.dequeueReusableCell(for: index) as CustomCell
	func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
		return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
	}

	func registerReusableSupplementaryView<T: Reusable>(_: T.Type, ofKind elementKind: String) {
		if let nib = T.nib {
			register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
		} else {
			register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
		}
	}

	func dequeueReusableSupplementaryView<T: UICollectionViewCell>(ofKind elementKind: String, for indexPath: IndexPath) -> T where T: Reusable {
		return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
	}
}
