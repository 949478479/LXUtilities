//
//  UIDevice+LXExtension.swift
//
//  Created by 从今以后 on 2017/10/7.
//  Copyright © 2017年 从今以后. All rights reserved.
//

import UIKit

extension Swifty where Base: UIDevice {
	
    static var isPhonePlus: Bool {
        return UIScreen.main.bounds.size == CGSize(width: 414, height: 736)
    }
    
	static var isPhoneX: Bool {
		return UIScreen.main.bounds.size == CGSize(width: 375, height: 812)
	}

    /// 获取当前设备 IPv4 地址信息。
    ///
    /// - Parameter completion: 请求完成回调
    ///   - info: 设备的 IPv4 地址信息，若请求失败，则为 `nil`
    ///   - error: 请求过程中发生的错误，若请求成功，则为 `nil`
    static func getIPInfo(completion: @escaping (_ info: UIDevice.IPInfo?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "http://ip.taobao.com/service/getIpInfo.php?ip=myip")!) { (data, response, error) in
            if let error = error {
                return completion(nil, error)
            }
            do {
                completion(try JSONDecoder().decode(UIDevice.IPInfoResponse.self, from: data!).data, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

extension UIDevice {

    struct IPInfo: Decodable {
        let country: String
        let country_id: String
        let area: String
        let area_id: String
        let region: String
        let region_id: String
        let city: String
        let city_id: String
        let county: String
        let county_id: String
        let isp: String
        let isp_id: String
        let ip: String
    }

    fileprivate struct IPInfoResponse: Decodable {
        let data: IPInfo
    }
}
