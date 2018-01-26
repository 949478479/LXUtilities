//
//  UICollectionView+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/19.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UICollectionView {

    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            base.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            base.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    // e.g. collectionView.dequeueReusableCell(for: index) as CustomCell
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        return base.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func registerReusableSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind elementKind: String) where T: Reusable {
        if let nib = T.nib {
            base.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            base.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T where T: Reusable {
        return base.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
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
        return base.indexPathsForSelectedItems?.flatMap { base.cellForItem(at: $0) }
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
