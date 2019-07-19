//
//  SCCompanyBalanceSheetStatement.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyBalanceSheetStatement: Decodable{
    let financials: [SCCompanyBalanceFinancialItem]?
}

struct SCCompanyBalanceFinancialItem: Decodable{
    let date: String?
    let cashAndCashEquivalents: String?
    let shortTermInvestments: String?
    let cashAndShortTermInvestments: String?
    let receivables: String?
    let inventories: String?
    let totalCurrentAssets: String?
    
    let propertyPlantEquipmentNet: String?
    let goodWillAndIntangibleAssets: String?
    let longTermInvestments: String?
    let taxAssets: String?
    let totalNonCurrentAssets: String?
    let totalAssets: String?
    let payablest: String?
    let shortTermDebt: String?
    let totalCurrentLiabilities: String?
    
    let longTermDebt: String?
    let totalDebt: String?
    let deferredRevenue: String?
    
    let taxLiabilities: String?
    let depositLiabilities: String?
    let totalNonCurrentLiabilities: String?
    let totalLiabilities: String?
    
    let otherComprehensiveIncome: String?
    let retainedEarningsDeficit: String?
    let totalShareholdersEquity: String?
    let investments: String?
    let netDebt: String?
    let otherAssets: String?
    let otherLiabilities: String?
    
    private enum CodingKeys: String, CodingKey {
        case date
        case cashAndCashEquivalents = "Cash and cash equivalents"
        case shortTermInvestments = "Short-term investments"
        case cashAndShortTermInvestments = "Cash and short-term investments"
        
        case receivables = "Receivables"
        case inventories = "Inventories"
        case totalCurrentAssets = "Total current assets"
        case propertyPlantEquipmentNet = "Property, Plant & Equipment Net"
        case goodWillAndIntangibleAssets = "Goodwill and Intangible Assets"
        
        case longTermInvestments = "Long-term investments"
        case taxAssets = "Tax assets"
        case totalNonCurrentAssets = "Total non-current assets"
        case totalAssets = "Total assets"
        case payablest = "Payables"
        case shortTermDebt = "Short-term debt"
        
        case totalCurrentLiabilities = "Total current liabilities"
        case longTermDebt = "Long-term debt"
        case totalDebt = "Total debt"
        case deferredRevenue = "Deferred revenue"
        case taxLiabilities = "Tax Liabilities"
        case depositLiabilities = "Deposit Liabilities"
        case totalNonCurrentLiabilities = "Total non-current liabilities"
        case totalLiabilities = "Total liabilities"
        case otherComprehensiveIncome = "Other comprehensive income"
        
        case retainedEarningsDeficit = "Retained earnings (deficit)"
        case totalShareholdersEquity = "Total shareholders equity"
        case investments = "Investments"
        case netDebt = "Net Debt"
        case otherAssets = "Other Assets"
        case otherLiabilities = "Other Liabilities"
    }
}
