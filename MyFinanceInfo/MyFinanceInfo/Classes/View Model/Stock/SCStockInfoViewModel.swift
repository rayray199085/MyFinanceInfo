//
//  SCStockInfoViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCStockInfoViewModel {
    let stockItem: SCStockListItem
    var price: String?
    var changes: String?
    var changesPercentage: String?
    var changesColour: UIColor?
    var changesPercentageColour: UIColor?
    var rowHeight: CGFloat?
    
    init(stockItem: SCStockListItem) {
        self.stockItem = stockItem
        if let price = stockItem.price{
            self.price = price != "" ? String(format: "%.2f$", Double(price) ?? 0) : ""
        }
        changesPercentage = stockItem.changesPercentage
        if changesPercentage?.hasPrefix("(") == true{
            changesPercentage?.removeFirst()
        }
        if changesPercentage?.hasSuffix(")") == true{
            changesPercentage?.removeLast()
        }
        
        rowHeight = calculateRowHeight(companyName: stockItem.companyName ?? "")
        
        let stockItemChanges = stockItem.changes ?? 0
        
        if stockItemChanges >= 0{
            changes = "+\(stockItemChanges)$"
            changesColour = InfoCommon.increasingPriceColor
            changesPercentageColour = InfoCommon.increasingPriceColor
        }else{
            changes = "\(stockItemChanges)$"
            changesColour = InfoCommon.decreasingPriceColor
            changesPercentageColour = InfoCommon.decreasingPriceColor
        }
    }
    
}
private extension SCStockInfoViewModel{    
    func calculateRowHeight(companyName: String)->CGFloat{
        let margin: CGFloat = 3
        let labelHeight: CGFloat = 18
        var height = margin + labelHeight
        height += margin
        let viewSize = CGSize(width: UIScreen.screenWidth() - 2 * margin, height: CGFloat(MAXFLOAT))
        height += companyName.getTextHeight(size: viewSize, font: UIFont.systemFont(ofSize: 15))
        height += margin + labelHeight
        height += margin * 4
        return height
    }
}
