//
//  SCCompanyFinancialRatios.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyFinancialRatios: Decodable {
    let ratios: [SCCompanyFinancialRatioItem]?
}

struct SCCompanyFinancialRatioItem: Decodable {
    let profitabilityIndicatorRatios: SCCompanyFinancialRatioPIR?
    let debtRatios: SCCompanyFinancialRatioDR?
    let investmentValuationRatios: SCCompanyFinancialRatioIVR?
}
struct SCCompanyFinancialRatioPIR: Decodable {
    let pretaxProfitMargin: String?
    let returnOnAssets: String?
    let returnOnEquity: String?
}
struct SCCompanyFinancialRatioDR: Decodable {
    let debtEquityRatio: String?
}

struct SCCompanyFinancialRatioIVR: Decodable {
    let priceEarningsRatio: String?
    let priceBookValueRatio: String?
}
