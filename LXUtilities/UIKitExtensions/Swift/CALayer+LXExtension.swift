//
//  CALayer+LXExtension.swift
//
//  Created by 从今以后 on 16/1/10.
//  Copyright © 2016年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: CALayer {

	private class AnimationDelegate: NSObject, CAAnimationDelegate {

		var completion: ((Bool) -> Void)?

		init(completion: @escaping (Bool) -> Void) {
			self.completion = completion
		}

		func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
			completion?(flag)
			completion = nil
		}
	}

	/// 添加动画。
	///
	/// - Parameters:
	///   - anim: 动画对象
	///   - key: 标识动画对象的字符串
	///   - completion: 动画结束回调。不要设置动画代理，否则闭包将无法回调。
	func add(_ anim: CAAnimation, forKey key: String? = nil, completion: ((Bool) -> Void)?) {
		if let completion = completion {
			anim.delegate = AnimationDelegate(completion: completion)
		}
		base.add(anim, forKey: key)
	}

	/// 暂停、恢复动画。
	var paused: Bool {
		set {
			guard newValue != paused else { return }
			if newValue {
				let pausedTime = base.convertTime(CACurrentMediaTime(), from: nil)
				base.speed = 0
				base.timeOffset = pausedTime
			} else {
				let pausedTime = base.timeOffset
				base.speed = 1.0
				base.timeOffset = 0.0
				base.beginTime = 0.0
				let timeSincePause = base.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
				base.beginTime = timeSincePause
			}
		}
		get {
			return base.speed == 0
		}
	}
}
