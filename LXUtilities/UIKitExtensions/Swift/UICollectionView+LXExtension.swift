//
//  UICollectionView+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/19.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UICollectionView {

    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
		base.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

	func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableView & NibLoadableView {
		base.register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
	}

    // e.g. collectionView.dequeueReusableCell(for: index) as CustomCell
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        return base.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func registerReusableSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind elementKind: String) where T: ReusableView {
		base.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }

	func registerReusableSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind elementKind: String) where T: ReusableView & NibLoadableView {
		base.register(T.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
	}

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T where T: ReusableView {
        return base.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

// MARK: - 刷新数据
extension Swifty where Base: UICollectionView {

    func reloadData(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.base.reloadData()
            DispatchQueue.main.async(execute: completion)
        }
    }
}

// MARK: - 选中管理
extension Swifty where Base: UICollectionView {

    func cellForSelectedItem() -> UICollectionViewCell? {
        if let indexPath = base.indexPathsForSelectedItems?.first {
            return base.cellForItem(at: indexPath)
        }
        return nil
    }

    func visibleCellsForSelectedItems() -> [UICollectionViewCell]? {
        return base.indexPathsForSelectedItems?.compactMap { base.cellForItem(at: $0) }
    }

    func selectItems(at indexPaths: [IndexPath]) {
        base.performBatchUpdates({
            indexPaths.forEach {
                base.selectItem(at: $0, animated: false, scrollPosition: [])
            }
        }, completion: nil)
    }
    
    func deselectAllItems() {
        if let indexPaths = base.indexPathsForSelectedItems {
            base.performBatchUpdates({
                indexPaths.forEach {
                    base.deselectItem(at: $0, animated: false)
                }
            }, completion: nil)
        }
    }
}
