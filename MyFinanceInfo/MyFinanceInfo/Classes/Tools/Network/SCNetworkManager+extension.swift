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
extension SCNetworkManager{
    func getCompanyProfile(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/company/profile/\(ticker)", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
    func getCompanyFinancialRatios(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/financial-ratios/\(ticker)", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
    func getCompanyRatings(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/company/rating/\(ticker)", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
    func getCompanyKeyMetrics(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/company-key-metrics/\(ticker)", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
    func getCompanyEnterpriseValue(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/enterprise-value/\(ticker)", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}
extension SCNetworkManager{
    func getIncomeStatement(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/financials/income-statement/\(ticker)", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}

extension SCNetworkManager{
    func getBalanceSheetStatement(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/financials/balance-sheet-statement/\(ticker)", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}

extension SCNetworkManager{
    func getCashFlowStatement(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/financials/cash-flow-statement/\(ticker)", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}
extension SCNetworkManager{
    func getFullHistoricalPrice(ticker: String, completion: @escaping (_ data: Data?, _ isSuccess: Bool)->()){
        let urlString = InfoCommon.baseUrl + "/historical-price-full/\(ticker)"
        let params = ["serietype": "candle"]
        request(urlString: urlString, method: HTTPMethod.get, params: params) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}

extension SCNetworkManager{
    func getMajorIndexes(completion:@escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/majors-indexes", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}
extension SCNetworkManager{
    func getCompanyList(completion:@escaping (_ data: Data?, _ isSuccess: Bool)->()){
        request(urlString: InfoCommon.baseUrl + "/company/stock/list", method: HTTPMethod.get, params: nil) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}

extension SCNetworkManager{
    func getTopHeadlines(pageIndex: Int, segmentName: String, completion:@escaping (_ data: Data?, _ isSuccess: Bool)->()){
        let countryCode = (UserDefaults.standard.object(forKey: InfoCommon.regionKey) as? String)  ?? "us"
        let params = ["category": segmentName,"page": "\(pageIndex)", "country": countryCode]
        request(urlString: InfoCommon.newsUrl, method: HTTPMethod.get, params: params) { (data, _, isSuccess, _, _) in
            completion(data, isSuccess)
        }
    }
}
