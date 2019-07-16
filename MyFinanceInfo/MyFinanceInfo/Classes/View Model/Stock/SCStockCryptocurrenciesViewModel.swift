//
//  SCStockCryptocurrenciesViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCStockCryptocurrenciesViewModel {
    let item: SCStockCryptocurrenciesListItem
    var changes: String?
    var price: String?
    var changesPercentage: String?
    var changesColour: UIColor?
    var changesPercentageColour: UIColor?
    
    init(item: SCStockCryptocurrenciesListItem) {
        self.item = item
        let itemChangesPercentage = (item.changes ?? 0).rounded(toPlaces: 2)
        let itemPrice = item.price ?? 0
        
        price = String(format: "%.4f$", (itemPrice).rounded(toPlaces: 4))
        
        let change = 1 + (item.changes ?? 0) / 100
        let itemChanges = String(format: "%.4f", (itemPrice - itemPrice / change).rounded(toPlaces: 4))
        
        if (item.changes ?? 0) >= 0{
            changes = "+\(itemChanges)"
            changesPercentage = String(format: "+%.2f%%", itemChangesPercentage)
            changesColour = InfoCommon.increasingPriceColor
            changesPercentageColour = InfoCommon.increasingPriceColor
        }else{
            changes = "\(itemChanges)"
            changesPercentage = String(format: "%.2f%%", itemChangesPercentage)
            changesColour = InfoCommon.decreasingPriceColor
            changesPercentageColour = InfoCommon.decreasingPriceColor
        }
    }
}
