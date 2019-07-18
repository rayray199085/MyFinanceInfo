//
//  SCCompanyIncomeStatement.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyIncomeStatement: Decodable{
    let financials: [SCCompanyIncomeFinancialItem]?
}

struct SCCompanyIncomeFinancialItem: Decodable{
    let date: String?
    let revenue: String?
    let revenueGrowth: String?
    let costOfRevenue: String?
    let grossProfit: String?
    let rdExpenses: String?
    let sgaExpense: String?
    
    let operatingExpenses: String?
    let operatingIncome: String?
    let interestExpense: String?
    let earningsBeforeTax: String?
    let incomeTaxExpense: String?
    let netIncomeNonControllingInt: String?
    let netIncomeDiscontinuedOps: String?
    let netIncome: String?
    let preferredDividends: String?
    let netIncomeCom: String?
    let eps: String?
    let epsDiluted: String?
    
    let weightedAverageShsOut: String?
    let weightedAverageShsOutDil: String?
    let dividendPerShare: String?
    let grossMargin: String?
    
    let eBITDAMargin: String?
    let eBITMargin: String?
    let profitMargin: String?
    let freeCashFlowMargin: String?
    let eBITDA: String?
    let eBIT: String?
    let consolidatedIncome: String?
    let earningsBeforeTaxMargin: String?
    let netProfitMargin: String?
    
    private enum CodingKeys: String, CodingKey {
        case date
        case revenue = "Revenue"
        case revenueGrowth = "Revenue Growth"
        case costOfRevenue = "Cost of Revenue"
        
        case grossProfit = "Gross Profit"
        case rdExpenses = "R&D Expenses"
        case sgaExpense = "SG&A Expense"
        case operatingExpenses = "Operating Expenses"
        case operatingIncome = "Operating Income"
        
        case interestExpense = "Interest Expense"
        case earningsBeforeTax = "Earnings before Tax"
        case incomeTaxExpense = "Income Tax Expense"
        case netIncomeNonControllingInt = "Net Income - Non-Controlling int"
        case netIncomeDiscontinuedOps = "Net Income - Discontinued ops"
        
        case netIncome = "Net Income"
        case preferredDividends = "Preferred Dividends"
        case netIncomeCom = "Net Income Com"
        case eps = "EPS"
        case epsDiluted = "EPS Diluted"
        case weightedAverageShsOut = "Weighted Average Shs Out"
        case weightedAverageShsOutDil = "Weighted Average Shs Out (Dil)"
        case dividendPerShare = "Dividend per Share"
        case grossMargin = "Gross Margin"
        
        case eBITDAMargin = "EBITDA Margin"
        case eBITMargin = "EBIT Margin"
        case profitMargin = "Profit Margin"
        case freeCashFlowMargin = "Free Cash Flow margin"
        case eBITDA = "EBITDA"
        case eBIT = "EBIT"
        case consolidatedIncome = "Consolidated Income"
        case earningsBeforeTaxMargin = "Earnings Before Tax Margin"
        case netProfitMargin = "Net Profit Margin"
    }
}
