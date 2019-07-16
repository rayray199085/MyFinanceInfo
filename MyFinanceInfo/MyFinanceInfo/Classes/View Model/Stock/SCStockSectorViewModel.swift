//
//  SCStockSectorViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 16/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCStockSectorViewModel {
    let item: SCStockSectorPerformanceItem
    var changesPercentage: String?
    var changesPercentageColor: UIColor?
    
    init(item: SCStockSectorPerformanceItem) {
        self.item = item
        if item.changesPercentage?.first == "-"{
            changesPercentage = item.changesPercentage
            changesPercentageColor = InfoCommon.decreasingPriceColor
        }else{
            changesPercentage = "+" + (item.changesPercentage ?? "0.0000%")
            changesPercentageColor = InfoCommon.increasingPriceColor
        }
    }
}
