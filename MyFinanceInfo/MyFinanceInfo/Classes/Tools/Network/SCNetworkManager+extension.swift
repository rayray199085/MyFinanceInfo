//
//  SCNetworkManager+extension.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

extension SCNetworkManager{
    func getStockData(suffix: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + suffix, method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}
