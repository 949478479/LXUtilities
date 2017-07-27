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
		func animationDidStart(_ anim: CAAnimation) {}
		func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
			completion?(flag)
			completion = nil
		}
	}

	/**
	添加动画。

	- parameter anim:       动画对象。
	- parameter key:        动画对象的键。
	- parameter completion: 动画完成或被移除时调用此闭包，注意不要设置动画代理,否则会造成覆盖。
	*/
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
				/* speed 设置为 0.0 将导致图层本地时间变为 0.0，而无论 beginTime 和 timeOffset 之前的值是多少，
				将 timeOffset 设置为图层本地时间，就可以在 speed 设置为 0.0 后保持图层本地时间不变，
				此时 speed 为 0.0，动画停止，且图层本地时间未变，因此动画会停止在原处。*/
				base.timeOffset = base.convertTime(CACurrentMediaTime(), from: nil)
				base.speed = 0
			} else {
				/* speed 设置为 1.0 后，图层本地时间会恢复正常。此时若将 timeOffset 重置为 0.0，即 timeOffset = 0.0，
				图层本地时间将等于绝对时间 CACurrentMediaTime()。但是暂停的这段时间内图层本地时间并未增长，
				应该减去这段时间，这个时间增量刚好是 CACurrentMediaTime() - timeOffset。若 beginTime 不为 0.0，
				还应加上该值。因此最终结果为 timeOffset = 0 - (CACurrentMediaTime() - timeOffset) + beginTime。
				这样图层的本地时间就会等于暂停前的值，此时 speed 恢复为 1.0，且图层本地时间未变，因此动画会从原处恢复。*/
				base.speed = 1
				base.timeOffset += base.beginTime - CACurrentMediaTime()
			}
		}
		get {
			return base.speed == 0
		}
	}
}


