//
//  UIImage+LXExtension.swift
//
//  Created by 从今以后 on 2018/11/1.
//  Copyright © 2018 从今以后. All rights reserved.
//

import UIKit

// MARK: - 缩略图
extension Swifty where Base: UIImage {

    /// 生成解码后的缩略图。缩略图和原始图片宽高比一致。
    ///
    /// - Parameters:
    ///   - url: 原始图片 URL。
    ///   - maxPixelSize: 缩略图宽或高的最大值。
    /// - Returns: 解码后的缩略图，若原始图片 URL 无效则返回 `nil`。
    static func thumbnail(with url: URL, maxPixelSize: CGFloat) -> UIImage? {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return nil
        }

        return thumbnail(with: source, maxPixelSize: maxPixelSize)
    }

    /// 生成解码后的缩略图。缩略图和原始图片宽高比一致。
    ///
    /// - Parameters:
    ///   - data: 原始图片数据。
    ///   - maxPixelSize: 缩略图宽或高的最大值。
    /// - Returns: 解码后的缩略图，若原始图片数据无效则返回 `nil`。
    static func thumbnail(with data: Data, maxPixelSize: CGFloat) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }

        return thumbnail(with: source, maxPixelSize: maxPixelSize)
    }

    private static func thumbnail(with source: CGImageSource, maxPixelSize: CGFloat) -> UIImage? {
        let options = [
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
        ] as CFDictionary

        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(source, 0, options) else {
            return nil
        }

        return UIImage(cgImage: downsampledImage)
    }

}
