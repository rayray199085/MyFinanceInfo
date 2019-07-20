//
//  SCBaseListViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 20/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCBaseListViewModel{
    var profileViewModel: SCCompanyProfileViewModel?
    var financialRatiosViewModel: SCCompanyFinancialRatiosViewModel?
    var enterpriseValueViewModel: SCCompanyEnterpriseValueViewModel?
    var keyMetricsViewModel: SCCompanyKeyMetricsViewModel?
    var ratingsViewModel: SCCompanyRatingsViewModel?
    
    var incomeStatementItems: [SCCompanyStatementItem]?
    var balanceSheetStatementItems: [SCCompanyStatementItem]?
    var cashFlowtStatementItems: [SCCompanyStatementItem]?
    var isDate: [String]?
    var bsDate: [String]?
    var cfDate: [String]?
    
    var historyViewModels: [SCCompanyHistoricalPriceViewModel]?
}
extension SCBaseListViewModel{
    func loadCompanyInfo(ticker: String, completion:@escaping (_ isSuccess: Bool)->()){
        let group = DispatchGroup()
        group.enter()
        SCNetworkManager.shared.getCompanyProfile(ticker: ticker) { (data, isSuccess) in
            if let data = data,
                let companyProfile = try? JSONDecoder().decode(SCCompanyProfile.self, from: data){
                self.profileViewModel = SCCompanyProfileViewModel(profile: companyProfile)
            }
            group.leave()
        }
        group.enter()
        SCNetworkManager.shared.getCompanyFinancialRatios(ticker: ticker) { (data, isSuccess) in
            if let data = data,
                let financialRatios = try? JSONDecoder().decode(SCCompanyFinancialRatios.self, from: data),
                let item = financialRatios.ratios?.first{
                
                self.financialRatiosViewModel = SCCompanyFinancialRatiosViewModel(item: item)
            }
            group.leave()
        }
        group.enter()
        SCNetworkManager.shared.getCompanyRatings(ticker: ticker) { (data, isSuccess) in
            if let data = data,
                let companyRatings = try? JSONDecoder().decode(SCCompanyRatings.self, from: data){
                self.ratingsViewModel = SCCompanyRatingsViewModel(ratings: companyRatings)
            }
            group.leave()
        }
        group.enter()
        SCNetworkManager.shared.getCompanyKeyMetrics(ticker: ticker) { (data, isSuccess) in
            if let data = data,
                let keyMetrics = try? JSONDecoder().decode(SCCompanyKeyMetrics.self, from: data),
                let item = keyMetrics.metrics?.first{
                self.keyMetricsViewModel = SCCompanyKeyMetricsViewModel(keyMetricsItem: item)
            }
            group.leave()
        }
        group.enter()
        SCNetworkManager.shared.getCompanyEnterpriseValue(ticker: ticker) { (data, isSuccess) in
            if let data = data,
                let enterpriseValue = try? JSONDecoder().decode(SCCompanyEnterpriseValue.self, from: data),
                let item = enterpriseValue.enterpriseValues?.first{
                self.enterpriseValueViewModel = SCCompanyEnterpriseValueViewModel(item: item)
            }
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            completion(true)
        }
    }
    
    func clearCompanyContent(){
        profileViewModel = nil
        financialRatiosViewModel = nil
        enterpriseValueViewModel = nil
        keyMetricsViewModel = nil
        ratingsViewModel = nil
        
        incomeStatementItems = nil
        balanceSheetStatementItems = nil
        cashFlowtStatementItems = nil
        
        historyViewModels = nil
    }
}
extension SCBaseListViewModel{
    func loadIncomeStatement(ticker: String, completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getIncomeStatement(ticker: ticker) { (data, isSuccess) in
            guard let data = data,
                let incomeStatement = try? JSONDecoder().decode(SCCompanyIncomeStatement.self, from: data) else{
                    completion(false)
                    return
            }
            var viewModels = SCCompanyISViewModels()
            for item in incomeStatement.financials?.reversed() ?? []{
                viewModels.setValues(item: item)
            }
            self.incomeStatementItems = viewModels.getStatementItems()
            self.isDate = viewModels.date
            completion(true)
        }
    }
}
extension SCBaseListViewModel{
    func loadBalanceSheetStatement(ticker: String, completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getBalanceSheetStatement(ticker: ticker) { (data, isSuccess) in
            guard let data = data,
                let balanceSheetStatement = try? JSONDecoder().decode(SCCompanyBalanceSheetStatement.self, from: data) else{
                    completion(false)
                    return
            }
            var viewModels = SCCompanyBSViewModels()
            for item in balanceSheetStatement.financials?.reversed() ?? []{
                viewModels.setValues(item: item)
            }
            self.balanceSheetStatementItems = viewModels.getStatementItems()
            self.bsDate = viewModels.date
            completion(true)
        }
    }
}
extension SCBaseListViewModel{
    func loadCashFlowStatement(ticker: String, completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getCashFlowStatement(ticker: ticker) { (data, isSuccess) in
            guard let data = data,
                let cashFlowStatement = try? JSONDecoder().decode(SCCompanyCashFlowStatement.self, from: data) else{
                    completion(false)
                    return
            }
            var viewModels = SCCompanyCFViewModels()
            for item in cashFlowStatement.financials?.reversed() ?? []{
                viewModels.setValues(item: item)
            }
            self.cashFlowtStatementItems = viewModels.getStatementItems()
            self.cfDate = viewModels.date
            completion(true)
        }
    }
}
extension SCBaseListViewModel{
    func loadFullHistoricalPrice(ticker: String, completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getFullHistoricalPrice(ticker: ticker) { (data, isSuccess) in
            guard let data = data,
                let historicalPriceItems = try? JSONDecoder().decode(SCCompanyHistoricalPrice.self, from: data) else{
                    completion(false)
                    return
            }
            var viewModels = [SCCompanyHistoricalPriceViewModel]()
            for item in historicalPriceItems.historical ?? []{
                viewModels.append(SCCompanyHistoricalPriceViewModel(item: item))
            }
            self.historyViewModels = viewModels
            completion(true)
        }
    }
}
