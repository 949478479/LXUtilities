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

extension Swifty where Base: UITableView {

    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            base.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            base.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    // e.g. tableView.dequeueReusableCell(for: indexPath) as CustomCell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        return base.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            base.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            base.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: Reusable {
        return base.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension Swifty where Base: UITableView {

    func updateTableHeaderViewHeight(withLayoutConfiguration configuration: (() -> Void)? = nil) {
        let headerView = base.tableHeaderView!
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = headerView.widthAnchor.constraint(equalToConstant: base.lx_width)
        widthConstraint.isActive = true
        configuration?()
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        widthConstraint.isActive = false
        headerView.translatesAutoresizingMaskIntoConstraints = true
        headerView.lx_height = height
        base.tableHeaderView = headerView
    }

    func updateTableFooterViewHeight(withLayoutConfiguration configuration: (() -> Void)? = nil) {
        let footerView = base.tableFooterView!
        footerView.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = footerView.widthAnchor.constraint(equalToConstant: base.lx_width)
        widthConstraint.isActive = true
        configuration?()
        let height = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        widthConstraint.isActive = false
        footerView.translatesAutoresizingMaskIntoConstraints = true
        footerView.lx_height = height
        base.tableHeaderView = footerView
    }
}

extension Swifty where Base: UITableView {

    func indexPathsInSection(_ section: Int) -> [IndexPath] {
        return (0..<base.numberOfRows(inSection: section)).map { IndexPath(row: $0, section: section) }
    }

    func indexPaths() -> [IndexPath] {
        return (0..<base.numberOfSections).flatMap { (section) -> [IndexPath] in
            (0..<base.numberOfRows(inSection: section)).map { (row) in
                IndexPath(row: row, section: section)
            }
        }
    }
    
    func indexPathsForSelectedRowsInSection(_ section: Int) -> [IndexPath]? {
        return base.indexPathsForSelectedRows?.filter { $0.section == section }
    }
}

extension Swifty where Base: UITableView {

    func selectRows(at indexPaths: [IndexPath], animated: Bool) {
        base.beginUpdates()
        indexPaths.forEach { base.selectRow(at: $0, animated: animated, scrollPosition: .none) }
        base.endUpdates()
    }

    func deselectRows(at indexPaths: [IndexPath], animated: Bool) {
        base.beginUpdates()
        indexPaths.forEach { base.deselectRow(at: $0, animated: animated) }
        base.endUpdates()
    }

    func selectRows(inSection section: Int, animated: Bool) {
        selectRows(at: indexPathsInSection(section), animated: animated)
    }

    func deselectRows(inSection section: Int, animated: Bool) {
        deselectRows(at: indexPathsInSection(section), animated: animated)
    }

    func selectAllRows() {
        base.beginUpdates()
        indexPaths().forEach {
            base.selectRow(at: $0, animated: false, scrollPosition: .none)
        }
        base.endUpdates()
    }

    func deselectAllRows() {
        base.beginUpdates()
        indexPaths().forEach {
            base.deselectRow(at: $0, animated: false)
        }
        base.endUpdates()
    }
}
