//
//  SCCompanyFinancialRatiosViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyFinancialRatiosViewModel {
    var operatingMargin: String?
    var roa: String?
    var roe: String?
    var debt: String?
    var pb: String?
    var pe: String?
    
    init(item: SCCompanyFinancialRatioItem) {        
        operatingMargin = getRatiosValueInPercentage(stringValue: item.profitabilityIndicatorRatios?.pretaxProfitMargin)
        roa = getRatiosValueInPercentage(stringValue: item.profitabilityIndicatorRatios?.returnOnAssets)
        roe = getRatiosValueInPercentage(stringValue: item.profitabilityIndicatorRatios?.returnOnEquity)
        debt = getRatiosValueInPercentage(stringValue: item.debtRatios?.debtEquityRatio)
        pb = getRatiosValue(stringValue: item.investmentValuationRatios?.priceBookValueRatio)
        pe = getRatiosValue(stringValue: item.investmentValuationRatios?.priceEarningsRatio)
    }
    
    func getRatiosValueInPercentage(stringValue: String?)->String{
        let value = Double(stringValue ?? "0") ?? 0
        return String(format: "%.2f%%", (value * 100).rounded(toPlaces: 2))
    }
    
    func getRatiosValue(stringValue: String?)->String{
        let value = Double(stringValue ?? "0") ?? 0
        return String(format: "%.2f", value.rounded(toPlaces: 2))
    }
}
