//
//  SCStockForexViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCStockForexViewModel {
    let item: SCStockForexListItem
    var changes: String?
    var price: String?
    var changesPercentage: String?
    var changesColour: UIColor?
    var changesPercentageColour: UIColor?
    
    init(item: SCStockForexListItem) {
        self.item = item
        let itemChangesPercentage = (item.changes ?? 0).rounded(toPlaces: 2)
        let itemAsk = Double(item.ask ?? "0") ?? 0.0
        
        price = String(format: "%.4f", (itemAsk).rounded(toPlaces: 4))
        
        let change = 1 + (item.changes ?? 0) / 100
        let itemChanges = String(format: "%.4f", (itemAsk - itemAsk / change).rounded(toPlaces: 4))
        
        if (item.changes ?? 0) >= 0{
            changes = "+\(itemChanges)"
            changesPercentage = String(format: "+%.2f%", itemChangesPercentage)
            changesColour = InfoCommon.increasingPriceColor
            changesPercentageColour = InfoCommon.increasingPriceColor
        }else{
            changes = "\(itemChanges)"
            changesPercentage = String(format: "%.2f%", itemChangesPercentage)
            changesColour = InfoCommon.decreasingPriceColor
            changesPercentageColour = InfoCommon.decreasingPriceColor
        }
    }
}
