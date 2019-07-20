//
//  SCSearchViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 20/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCSearchViewModel {
    var rowHeight: CGFloat?
    var ticker: String?
    var displayText: String?
    
    init(item: SCSearchCompanyItem) {
        ticker = item.symbol
        if let name = item.name,
           let ticker = ticker{
            displayText = "\(name) (\(ticker))"
            rowHeight = calculateRowHeight(text: displayText!)
            return
        }
        rowHeight = 0
    }
}
private extension SCSearchViewModel{
    func calculateRowHeight(text: String)->CGFloat{
        let margin: CGFloat = 3
        let tableIndexViewWidth: CGFloat = 20
        var height = margin
        let viewSize = CGSize(width: UIScreen.screenWidth() - 2 * margin - tableIndexViewWidth, height: CGFloat(MAXFLOAT))
        height += text.getTextHeight(size: viewSize, font: UIFont.systemFont(ofSize: 15))
        height += margin * 4
        return height
    }
}
