//
//  UITableView+LXExtension.swift
//
//  Created by 从今以后 on 2017/9/19.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UITableView {

    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: ReusableView {
		base.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

	func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: ReusableView & NibLoadableView {
		base.register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
	}

    // e.g. tableView.dequeueReusableCell(for: indexPath) as CustomCell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        return base.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView {
		base.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

	func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView & NibLoadableView {
		base.register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
	}

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReusableView {
        return base.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension Swifty where Base: UITableView {

    func updateTableHeaderViewHeight(withLayoutConfiguration configuration: (() -> Void)? = nil) {
        let headerView = base.tableHeaderView!
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = headerView.widthAnchor.constraint(equalToConstant: base.lx.width)
        widthConstraint.isActive = true
        configuration?()
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        widthConstraint.isActive = false
        headerView.translatesAutoresizingMaskIntoConstraints = true
        headerView.lx.height = height
        base.tableHeaderView = headerView
    }

    func updateTableFooterViewHeight(withLayoutConfiguration configuration: (() -> Void)? = nil) {
        let footerView = base.tableFooterView!
        footerView.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = footerView.widthAnchor.constraint(equalToConstant: base.lx.width)
        widthConstraint.isActive = true
        configuration?()
        let height = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        widthConstraint.isActive = false
        footerView.translatesAutoresizingMaskIntoConstraints = true
        footerView.lx.height = height
        base.tableFooterView = footerView
    }
}

// MARK: - 刷新数据
extension Swifty where Base: UITableView {

    func reloadData(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.base.reloadData()
            DispatchQueue.main.async(execute: completion)
        }
    }
}

// MARK: - 访问单元格
extension Swifty where Base: UITableView {

    func indexPathsInSection(_ section: Int) -> [IndexPath]? {
        let indexPaths = (0..<base.numberOfRows(inSection: section)).map {
            IndexPath(row: $0, section: section)
        }
        return indexPaths.isEmpty ? nil : indexPaths
    }

    func allIndexPaths() -> [IndexPath]? {
        let indexPaths = (0..<base.numberOfSections).flatMap { (section) -> [IndexPath] in
            (0..<base.numberOfRows(inSection: section)).map { (row) in
                IndexPath(row: row, section: section)
            }
        }
        return indexPaths.isEmpty ? nil : indexPaths
    }
    
    func indexPathsForSelectedRowsInSection(_ section: Int) -> [IndexPath]? {
        return base.indexPathsForSelectedRows?.filter { $0.section == section }
    }

    func cellForSelectedRow() -> UITableViewCell? {
        guard let indexPath = base.indexPathForSelectedRow else {
            return nil
        }
        guard let cell = base.cellForRow(at: indexPath) else {
            return nil
        }
        return cell
    }

    func cellsForSelectedRows() -> [UITableViewCell]? {
        return base.indexPathsForSelectedRows?.compactMap { base.cellForRow(at: $0) }
    }
}

// MARK: - 选中
extension Swifty where Base: UITableView {

    func selectRows(at indexPaths: [IndexPath], animated: Bool) {
        UIView.performWithoutAnimation {
            base.beginUpdates()
            indexPaths.forEach { base.selectRow(at: $0, animated: animated, scrollPosition: .none) }
            base.endUpdates()
        }
    }

    func deselectRows(at indexPaths: [IndexPath], animated: Bool) {
        UIView.performWithoutAnimation {
            base.beginUpdates()
            indexPaths.forEach { base.deselectRow(at: $0, animated: animated) }
            base.endUpdates()
        }
    }

    func selectRows(inSection section: Int, animated: Bool) {
        guard let indexPaths = indexPathsInSection(section) else {
            return
        }
        selectRows(at: indexPaths, animated: animated)
    }

    func deselectRows(inSection section: Int, animated: Bool) {
        guard let indexPaths = indexPathsInSection(section) else {
            return
        }
        deselectRows(at: indexPaths, animated: animated)
    }

    func selectAllRows() {
        guard let indexPaths = allIndexPaths() else {
            return
        }
        UIView.performWithoutAnimation {
            base.beginUpdates()
            indexPaths.forEach { base.selectRow(at: $0, animated: false, scrollPosition: .none) }
            base.endUpdates()
        }
    }

    func deselectAllRows() {
        guard let indexPaths = base.indexPathsForSelectedRows else {
            return
        }
        UIView.performWithoutAnimation {
            base.beginUpdates()
            indexPaths.forEach { base.deselectRow(at: $0, animated: false) }
            base.endUpdates()
        }
    }
}
