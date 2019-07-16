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
