//
//  SCIndexesViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
struct SCIndexesViewModel {
    var indexName: String?
    var price: String?
    var changes: String?
    var changesPercentage: String?
    var changesLabelColor: UIColor?
    var changesPercentageLabelColor: UIColor?
    
    init(item: SCIndexesListItem) {
        indexName = item.indexName
        price = getValueFrom(rawValue: item.price)
        let changesString = getValueFrom(rawValue: item.changes)
        let changesPercentageString = getValueInPercentage(changeValue: item.changes, priceValue: item.price)
        if (item.changes ?? 0) >= 0{
            changes = "+" + changesString
            changesPercentage = "+" + changesPercentageString
            changesLabelColor = InfoCommon.increasingPriceColor
            changesPercentageLabelColor = InfoCommon.increasingPriceColor
        }else{
            changes = changesString
            changesPercentage = changesPercentageString
            changesLabelColor = InfoCommon.decreasingPriceColor
            changesPercentageLabelColor = InfoCommon.decreasingPriceColor
        }
    }
    private func getValueFrom(rawValue: Double?)->String{
        return String(format: "%.2f", (rawValue?.rounded(toPlaces: 2) ?? 0))
    }
    private func getValueInPercentage(changeValue: Double?, priceValue: Double?)->String{
        guard let changeValue = changeValue,
            let priceValue = priceValue else{
                return ""
        }
        return getValueFrom(rawValue: changeValue * 100 / priceValue) + "%"
    }
}
