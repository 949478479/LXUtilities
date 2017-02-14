//
//  LXUIUtilities.h
//
//  Created by 从今以后 on 17/2/15.
//  Copyright © 2017年 从今以后. All rights reserved.
//

#import <CoreGraphics/CGGeometry.h>
#import <MapKit/MKGeometry.h>
#import <UIKit/UIGeometry.h>

#pragma mark - 取整、像素对齐

/// 将以 pt 为单位的浮点值沿靠近 0 的方向像素对齐
CG_INLINE CGFloat
LXFloorInPixel(CGFloat value, CGFloat scale) {
	if (value > 0)
		return floor(value * scale) / scale;
	if (value < 0)
		return ceil(value * scale) / scale;
	return 0;
}

/// 将以 pt 为单位的浮点值沿靠近 0 的方向取整
CG_INLINE CGFloat
LXFloorInPoint(CGFloat value) {
	if (value > 0)
		return floor(value);
	if (value < 0)
		return ceil(value);
	return 0;
}

/// 将以 pt 为单位的浮点值沿远离 0 的方向像素对齐
CG_INLINE CGFloat
LXCeilInPixel(CGFloat value, CGFloat scale) {
	if (value > 0)
		return ceil(value * scale) / scale;
	if (value < 0)
		return floor(value * scale) / scale;
	return 0;
}

/// 将以 pt 为单位的浮点值沿远离 0 的方向取整
CG_INLINE CGFloat
LXCeilInPoint(CGFloat value) {
	if (value > 0)
		return ceil(value);
	if (value < 0)
		return floor(value);
	return 0;
}

/// 将以 pt 为单位的浮点值四舍五入像素对齐
CG_INLINE CGFloat
LXRoundInPixel(CGFloat value, CGFloat scale) {
	return round(value * scale) / scale;
}

/// 将以 pt 为单位的浮点值四舍五入取整
CG_INLINE CGFloat
LXRoundInPoint(CGFloat value) {
	return round(value);
}

#pragma mark - CGPoint

/// 将一个以 pt 为单位 CGPoint 的坐标沿正方向调整从而像素对齐
CG_INLINE CGPoint
LXPointCeilInPixel(CGPoint point, CGFloat scale) {
	return CGPointMake(ceil(point.x * scale) / scale, ceil(point.y * scale) / scale);
}

/// 将一个以 pt 为单位 CGPoint 的坐标沿负方向调整从而像素对齐
CG_INLINE CGPoint
LXPointFloorInPixel(CGPoint point, CGFloat scale) {
	return CGPointMake(floor(point.x * scale) / scale, floor(point.y * scale) / scale);
}

#pragma mark - CGSize

CG_INLINE BOOL
LXSizeIsEmpty(CGSize size) {
	return size.width <= 0 || size.height <= 0;
}

CG_INLINE CGFloat
LXSizeGetMidX(CGSize size) {
	return size.width / 2;
}

CG_INLINE CGFloat
LXSizeGetMidY(CGSize size) {
	return size.height / 2;
}

/// 将一个以 pt 为单位的 CGSize 的宽高沿远离 0 的方向调整从而像素对齐
CG_INLINE CGSize
LXSizeCeilInPixel(CGSize size, CGFloat scale) {
	return CGSizeMake(LXCeilInPixel(size.width, scale), LXCeilInPixel(size.height, scale));
}

/// 将一个以 pt 为单位的 CGSize 的宽高沿靠近 0 的方向调整从而像素对齐
CG_INLINE CGSize
LXSizeFloorInPixel(CGSize size, CGFloat scale) {
	return CGSizeMake(LXFloorInPixel(size.width, scale), LXFloorInPixel(size.height, scale));
}

/// 将一个以 pt 为单位的 CGSize 的宽高向上取整
CG_INLINE CGSize
LXSizeCeil(CGSize size) {
	return CGSizeMake(LXCeilInPoint(size.width), LXCeilInPoint(size.height));
}

/// 将一个以 pt 为单位的 CGSize 的宽高向下取整
CG_INLINE CGSize
LXSizeFloor(CGSize size) {
	return CGSizeMake(LXFloorInPoint(size.width), LXFloorInPoint(size.height));
}

#pragma mark - CGRect

CG_INLINE CGRect
LXRectMakeWithSize(CGSize size) {
	return CGRectMake(0, 0, size.width, size.height);
}

CG_INLINE CGRect
LXRectSetX(CGRect rect, CGFloat x) {
	rect.origin.x = x;
	return rect;
}

CG_INLINE CGRect
LXRectSetY(CGRect rect, CGFloat y) {
	rect.origin.y = y;
	return rect;
}

CG_INLINE CGRect
LXRectSetXY(CGRect rect, CGFloat x, CGFloat y) {
	rect.origin.x = x;
	rect.origin.y = y;
	return rect;
}

CG_INLINE CGRect
LXRectSetWidth(CGRect rect, CGFloat width) {
	rect.size.width = width;
	return rect;
}

CG_INLINE CGRect
LXRectSetHeight(CGRect rect, CGFloat height) {
	rect.size.height = height;
	return rect;
}

CG_INLINE CGRect
LXRectSetSize(CGRect rect, CGSize size) {
	rect.size = size;
	return rect;
}

CG_INLINE CGPoint
LXRectGetCenter(CGRect rect) {
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

/// 对一个以 pt 为单位的 CGRect 进行像素对齐，origin 沿负方向对齐，size 沿正方向对齐
CG_INLINE CGRect
LXRectFlatted(CGRect rect, CGFloat scale) {
	rect.origin = LXPointFloorInPixel(rect.origin, scale);
	rect.size = LXSizeCeilInPixel(rect.size, scale);
	return rect;
}

/// 创建一个以 pt 为单位像素对齐的 CGRect，x 和 y 沿负方向对齐，width 和 height 沿正方向对齐
CG_INLINE CGRect
LXRectFlatMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height, CGFloat scale) {
	return CGRectMake(floor(x * scale) / scale,
					  floor(y * scale) / scale,
					  LXCeilInPixel(width, scale),
					  LXCeilInPixel(height, scale));
}

#pragma mark - UIEdgeInsets

CG_INLINE UIEdgeInsets
LXEdgeInsetsSetTop(UIEdgeInsets insets, CGFloat top) {
	insets.top = top;
	return insets;
}

CG_INLINE UIEdgeInsets
LXEdgeInsetsSetLeft(UIEdgeInsets insets, CGFloat left) {
	insets.left = left;
	return insets;
}

CG_INLINE UIEdgeInsets
LXEdgeInsetsSetBottom(UIEdgeInsets insets, CGFloat bottom) {
	insets.bottom = bottom;
	return insets;
}

CG_INLINE UIEdgeInsets
LXEdgeInsetsSetRight(UIEdgeInsets insets, CGFloat right) {
	insets.right = right;
	return insets;
}

#pragma mark - CGAffineTransform

/// 缩放并平移，缩放不影响平移量
CG_INLINE CGAffineTransform
LXAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy, CGFloat tx, CGFloat ty) {
	return CGAffineTransformMake(sx, 0, 0, sy, tx, ty);
}

#pragma mark - MKMapRect

CG_INLINE MKMapRect
LXMapRectForCoordinateRegion(MKCoordinateRegion region) {
	CLLocationCoordinate2D coordinateA = {
		region.center.latitude + region.span.latitudeDelta / 2,
		region.center.longitude - region.span.longitudeDelta / 2,
	};

	CLLocationCoordinate2D coordinateB = {
		region.center.latitude - region.span.latitudeDelta / 2,
		region.center.longitude + region.span.longitudeDelta / 2,
	};

	MKMapPoint a = MKMapPointForCoordinate(coordinateA);
	MKMapPoint b = MKMapPointForCoordinate(coordinateB);

	return MKMapRectMake(MIN(a.x, b.x), MIN(a.y, b.y), ABS(a.x - b.x), ABS(a.y - b.y));
}
