//
//  UIView+LXExtension.swift
//
//  Created by 从今以后 on 15/11/17.
//  Copyright © 2015年 从今以后. All rights reserved.
//

import UIKit

/// 根据类名同名 `xib` 文件实例化视图。
extension Swifty where Base: UIView {

	static func instantiateFromNib(withOwner ownerOrNil: AnyObject? = nil, options optionsOrNil: [AnyHashable: Any]? = nil) -> Base {
		let views = UINib(nibName: String(describing: Base.self), bundle: nil).instantiate(withOwner: ownerOrNil, options: optionsOrNil)
		guard let view = views.first(where: { type(of: $0) == Base.self }) as? Base else {
			fatalError("\(String(describing: Base.self)).xib 文件中未找到对应实例.")
		}
		return view
	}

	func viewController() -> UIViewController? {
		var responder = base.next
		while let _responder = responder, !(_responder is UIViewController) {
			responder = _responder.next
		}
		return responder as? UIViewController
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
