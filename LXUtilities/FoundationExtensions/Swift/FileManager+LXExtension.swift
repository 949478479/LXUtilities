//
//  FileManager+LXExtension.swift
//  这到底是什么鬼
//
//  Created by 不知什么人 on 2021/5/7.
//  Copyright © 2021 XinMo. All rights reserved.
//

import Foundation

extension Swifty where Base == FileManager {

    func sizeOfItem(at url: URL) -> Int {
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: url.path) else {
            return 0
        }

        let type = attributes[.type] as! FileAttributeType

        if type == .typeRegular {
            return attributes[.size] as! Int
        }

        guard type == .typeDirectory else {
            return 0
        }

        let resourceKeys = Set<URLResourceKey>([.fileSizeKey, .isRegularFileKey])
        guard let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: Array(resourceKeys)) else {
            return 0
        }

        var size = 0
        for case let fileURL as URL in enumerator {
            guard
                let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
                let isRegularFile = resourceValues.isRegularFile, isRegularFile,
                let fileSize = resourceValues.fileSize
            else {
                continue
            }

            size += fileSize
        }
        return size
    }
}
