//
//  CLLocation+LXExtension.swift
//  ofo_demo
//
//  Created by 从今以后 on 2017/7/14.
//  Copyright © 2017年 从今以后. All rights reserved.
//

extension CLLocationCoordinate2D {

	static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
	}

	static func !=(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
		return !(lhs == rhs)
	}
}
