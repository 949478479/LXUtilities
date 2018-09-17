//
//  NotificationCenter+LXExtension.swift
//
//  Created by 从今以后 on 2018/9/17.
//  Copyright © 2018年 从今以后. All rights reserved.
//

import Foundation

final class NotificationToken: NSObject {

    let notificationCenter: NotificationCenter
    let observer: Any

    deinit {
        notificationCenter.removeObserver(observer)
    }

    init(notificationCenter: NotificationCenter = .default, observer: Any) {
        self.notificationCenter = notificationCenter
        self.observer = observer
    }

}

extension Swifty where Base: NotificationCenter {

    func addOneshotObserver(
        forName name: NSNotification.Name?,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping (Notification) -> Swift.Void)
    {
        var observer: NSObjectProtocol?
        observer = base.addObserver(forName: name, object: obj, queue: queue) { [weak base] in
            defer { base?.removeObserver(observer!) }
            block($0)
        }
    }

    func addObserver(
        forName name: NSNotification.Name?,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping (Notification) -> Swift.Void)
        -> NotificationToken
    {
        let observer = base.addObserver(forName: name, object: obj, queue: queue, using: block)
        return NotificationToken(notificationCenter: base, observer: observer)
    }

}
