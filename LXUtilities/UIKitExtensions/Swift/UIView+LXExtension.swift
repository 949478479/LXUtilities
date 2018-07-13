//
//  UIView+LXExtension.swift
//
//  Created by 从今以后 on 15/11/17.
//  Copyright © 2015年 从今以后. All rights reserved.
//

import UIKit

// MARK: - 协议
protocol ConfigurableView: class {
    associatedtype ViewModel
    var viewModel: ViewModel? { get }
    func configure(with viewModel: ViewModel)
}

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

// MARK: - 控制器
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

// MARK: - 实例化
extension Swifty where Base: UIView & NibLoadableView {

	static func instantiateFromNib(
        withOwner ownerOrNil: AnyObject? = nil,
        options optionsOrNil: [AnyHashable: Any]? = nil)
        -> Base
    {
		let views = Base.nib!.instantiate(withOwner: ownerOrNil, options: optionsOrNil)
		guard let view = views.first(where: { type(of: $0) == Base.self }) as? Base else {
			fatalError("\(String(describing: Base.self)).xib 文件中未找到对应实例.")
		}
		return view
	}
}

// MARK: - 几何
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

// MARK: - 动画
extension Swifty where Base: UIView {

	func addShakeAnimation(repeatCount: Float = 0) {
		guard base.layer.animation(forKey: "shake") == nil else { return }

		let animation = CAKeyframeAnimation(keyPath: "position.x")
		animation.duration = 0.4
		animation.isAdditive = true
		animation.values = [0, 10, -10, 10, 0, 0]
		animation.keyTimes = [0, 1.0/6, 3.0/6, 5.0/6, 1] as [NSNumber]
        animation.timingFunctions = [
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
            CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),
        ]
        
		let group = CAAnimationGroup()
		group.animations = [animation]
		group.repeatCount = repeatCount
		group.isRemovedOnCompletion = false
		group.duration = animation.duration + (repeatCount > 0 ? 1 : 0)

		base.layer.add(group, forKey: "shake")
	}

	func removeShakeAnimation() {
		base.layer.removeAnimation(forKey: "shake")
	}
}
