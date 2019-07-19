//
//  SCCompanyCashFlowStatement.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyCashFlowStatement: Decodable{
    let financials: [SCCompanyCashFlowFinancialItem]?
}

struct SCCompanyCashFlowFinancialItem: Decodable {
    let date: String?
    let depreciationAmortization: String?
    let stockBasedCompensation: String?
    let operatingCashFlow: String?
    let capitalExpenditure: String?
    let acquisitionsAndDisposals: String?
    let investmentPurchasesAndSales: String?
    
    let investingCashFlow: String?
    let issuanceRepaymentOfDebt: String?
    let issuanceBuybacksOfShares: String?
    let dividendPayments: String?
    let financingCashFlow: String?
    let effectOfForexChangesOnCash: String?
    let netCashFlowChangeInCash: String?
    let freeCashFlow: String?
    let netCashMarketcap: String?
    
    private enum CodingKeys: String, CodingKey {
        case date
        case depreciationAmortization = "Depreciation & Amortization"
        case stockBasedCompensation = "Stock-based compensation"
        
        case operatingCashFlow = "Operating Cash Flow"
        case capitalExpenditure = "Capital Expenditure"
        case acquisitionsAndDisposals = "Acquisitions and disposals"
        case investmentPurchasesAndSales = "Investment purchases and sales"
        case investingCashFlow = "Investing Cash flow"
        
        case issuanceRepaymentOfDebt = "Issuance (repayment) of debt"
        case issuanceBuybacksOfShares = "Issuance (buybacks) of shares"
        case dividendPayments = "Dividend payments"
        case financingCashFlow = "Financing Cash Flow"
        case effectOfForexChangesOnCash = "Effect of forex changes on cash"
        case netCashFlowChangeInCash = "Net cash flow / Change in cash"
        
        case freeCashFlow = "Free Cash Flow"
        case netCashMarketcap = "Net Cash/Marketcap"
    }
}
