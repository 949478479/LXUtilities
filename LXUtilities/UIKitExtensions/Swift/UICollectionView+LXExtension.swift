//
//  UICollectionView+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/19.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

// MARK: - 数据源
extension Swifty where Base: UICollectionView {

    func registerReusableCell<T: UICollectionViewCell & ReusableView>(_: T.Type) {
		base.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

	func registerReusableCell<T: UICollectionViewCell & ReusableView & NibLoadableView>(_: T.Type) {
		base.register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
	}

    // e.g. collectionView.dequeueReusableCell(for: index) as CustomCell
    func dequeueReusableCell<T: UICollectionViewCell & ReusableView>(for indexPath: IndexPath) -> T {
        return base.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func registerReusableSupplementaryView<T: UICollectionReusableView & ReusableView>(_: T.Type, ofKind elementKind: String) {
		base.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }

	func registerReusableSupplementaryView<T: UICollectionReusableView & ReusableView & NibLoadableView>(_: T.Type, ofKind elementKind: String) {
		base.register(T.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
	}

    func dequeueReusableSupplementaryView<T: UICollectionReusableView & ReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T {
        return base.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

// MARK: - 刷新数据
extension Swifty where Base: UICollectionView {

    func reloadData(completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion()
        }
        base.reloadData()
        CATransaction.commit()
    }
}

// MARK: - 单元格
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
}

// MARK: - 选中
extension Swifty where Base: UICollectionView {

    func selectItems(at indexPaths: [IndexPath]) {
        UIView.performWithoutAnimation {
            base.performBatchUpdates({
                indexPaths.forEach { base.selectItem(at: $0, animated: false, scrollPosition: []) }
            }, completion: nil)
        }
    }
}

// MARK: - 反选
extension Swifty where Base: UICollectionView {

    func deselectAllItems() {
        guard let indexPaths = base.indexPathsForSelectedItems else {
            return
        }

        UIView.performWithoutAnimation {
            base.performBatchUpdates({
                indexPaths.forEach {
                    base.deselectItem(at: $0, animated: false)
                }
            }, completion: nil)
        }
    }
}
