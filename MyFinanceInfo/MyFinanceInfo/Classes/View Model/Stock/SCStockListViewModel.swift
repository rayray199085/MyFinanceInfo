//
//  SCStockListViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCStockListViewModel {
    private let suffixArray = ["/stock/actives", "/stock/gainers",
                               "/stock/losers","/forex",
                               "/cryptocurrencies","/stock/sectors-performance"]
    var previewIndex: Int = -1
    var infoViewModels: [SCStockInfoViewModel]?
    var forexViewModels: [SCStockForexViewModel]?
    var cryptocurrenciesViewModels: [SCStockCryptocurrenciesViewModel]?
    var sectorPerformanceViewModels: [SCStockSectorViewModel]?
    
    var profileViewModel: SCCompanyProfileViewModel?
    var financialRatiosViewModel: SCCompanyFinancialRatiosViewModel?
    var enterpriseValueViewModel: SCCompanyEnterpriseValueViewModel?
    var keyMetricsViewModel: SCCompanyKeyMetricsViewModel?
    var ratingsViewModel: SCCompanyRatingsViewModel?
    
    var incomeStatementItems: [SCCompanyStatementItem]?
    var date: [String]?
    
    func loadStockData(index: Int, completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getStockData(suffix: suffixArray[index]) { (data, isSuccess) in
            guard let data = data else{
                completion(false)
                return
            }
            switch index{
            case 0:
                guard let activeItems = try? JSONDecoder().decode(SCStockMostActive.self, from: data).mostActiveStock else{
                    completion(false)
                    return
                }
                self.infoViewModels = self.getInfoViewModels(items: activeItems)
            case 1:
                guard let gainerItems = try? JSONDecoder().decode(SCStockMostGainer.self, from: data).mostGainerStock else{
                    completion(false)
                    return
                }
                self.infoViewModels = self.getInfoViewModels(items: gainerItems)
            case 2:
                guard let loserItems = try? JSONDecoder().decode(SCStockMostLoser.self, from: data).mostLoserStock else{
                    completion(false)
                    return
                }
                self.infoViewModels = self.getInfoViewModels(items: loserItems)
            case 3:
                guard let forexList = try? JSONDecoder().decode(SCStockForexList.self, from: data).forexList else{
                    completion(false)
                    return
                }
                var viewModels = [SCStockForexViewModel]()
                for forexItem in forexList{
                    viewModels.append(SCStockForexViewModel(item: forexItem))
                }
                self.forexViewModels = viewModels
            case 4:
                guard let cryptocurrenciesList = try? JSONDecoder().decode(SCStockCryptocurrenciesList.self, from: data).cryptocurrenciesList else{
                    completion(false)
                    return
                }
                var viewModels = [SCStockCryptocurrenciesViewModel]()
                for item in cryptocurrenciesList{
                    viewModels.append(SCStockCryptocurrenciesViewModel(item: item))
                }
                self.cryptocurrenciesViewModels = viewModels
            case 5:
                guard let sectorPerformance = try? JSONDecoder().decode(SCStockSectorPerformance.self, from: data).sectorPerformance else{
                    completion(false)
                    return
                }
                var viewModels = [SCStockSectorViewModel]()
                for item in sectorPerformance{
                    viewModels.append(SCStockSectorViewModel(item: item))
                }
                self.sectorPerformanceViewModels = viewModels
            default:
                break
            }
            self.previewIndex = index
            completion(true)
        }
    }
    private func getInfoViewModels(items: [SCStockListItem])->[SCStockInfoViewModel]{
        var viewModels = [SCStockInfoViewModel]()
        for item in items{
            viewModels.append(SCStockInfoViewModel(stockItem: item))
        }
        return viewModels
    }
}
extension SCStockListViewModel{
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
    }
}
extension SCStockListViewModel{
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
            self.date = viewModels.date
            completion(true)
        }
    }
}
