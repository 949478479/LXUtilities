//
//  UIView+LXExtension.swift
//
//  Created by 从今以后 on 15/11/17.
//  Copyright © 2015年 从今以后. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension ReusableView where Self: UIView {

	static var reuseIdentifier: String {
		return String(describing: self)
	}
}

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {

	static var nib: UINib? {
		return UINib(nibName: String(describing: self), bundle: nil)
	}
}

extension Swifty where Base: UIView {

	func viewController() -> UIViewController? {
        var responder: UIResponder? = base.next
        repeat {
            if let responder = responder as? UIViewController {
                return responder
            }
            responder = responder?.next
        } while responder != nil
        return nil
	}
}

extension Swifty where Base: UIView & NibLoadableView {

	static func instantiateFromNib(withOwner ownerOrNil: AnyObject? = nil, options optionsOrNil: [AnyHashable: Any]? = nil) -> Base {
		let views = Base.nib!.instantiate(withOwner: ownerOrNil, options: optionsOrNil)
		guard let view = views.first(where: { type(of: $0) == Base.self }) as? Base else {
			fatalError("\(String(describing: Base.self)).xib 文件中未找到对应实例.")
		}
		return view
	}
}

extension Swifty where Base: UIView {

    var originX: CGFloat {
        set { base.frame.origin.x = newValue }
        get { return base.frame.origin.x }
    }

    var originY: CGFloat {
        set { base.frame.origin.y = newValue }
        get { return base.frame.origin.y }
    }

    var width: CGFloat {
        set { base.frame.size.width = newValue }
        get { return base.frame.width }
    }

    var height: CGFloat {
        set { base.frame.size.height = newValue }
        get { return base.frame.height }
    }

    var centerX: CGFloat {
        set { base.center.x = newValue }
        get { return base.center.x }
    }

    var centerY: CGFloat {
        set { base.center.y = newValue }
        get { return base.center.y }
    }
}
