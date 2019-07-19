//
//  SCCompanyCFViewModels.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyCFViewModels {
    private let titles = ["Depreciation & Amortization",
                          "Stock-based compensation",
                          "Operating Cash Flow",
                          "Capital Expenditure",
                          "Acquisitions and disposals",
                          "Investment purchases and sales",
                          "Investing Cash flow",
                          "Issuance (repayment) of debt",
                          "Issuance (buybacks) of shares",
                          "Dividend payments",
                          "Financing Cash Flow",
                          "Effect of forex changes on cash",
                          "Net cash flow / Change in cash",
                          "Free Cash Flow",
                          "Net Cash/Marketcap"]
    var date = [String]()
    private var depreciationAmortization = [Double]()
    private var stockBasedCompensation = [Double]()
    private var operatingCashFlow = [Double]()
    private var capitalExpenditure = [Double]()
    private var acquisitionsAndDisposals = [Double]()
    private var investmentPurchasesAndSales = [Double]()
    
    private var investingCashFlow = [Double]()
    private var issuanceRepaymentOfDebt = [Double]()
    private var issuanceBuybacksOfShares = [Double]()
    private var dividendPayments = [Double]()
    private var financingCashFlow = [Double]()
    private var effectOfForexChangesOnCash = [Double]()
    private var netCashFlowChangeInCash = [Double]()
    private var freeCashFlow = [Double]()
    private var netCashMarketcap = [Double]()
    
    mutating func setValues(item: SCCompanyCashFlowFinancialItem) {
        date.append(((item.date ?? "") as NSString).substring(with: NSRange(location: 0, length: 4)))
        depreciationAmortization.append(getValueFrom(stringValue: item.depreciationAmortization))
        
        stockBasedCompensation.append(getValueFrom(stringValue: item.stockBasedCompensation))
        operatingCashFlow.append(getValueFrom(stringValue: item.operatingCashFlow))
        capitalExpenditure.append(getValueFrom(stringValue: item.capitalExpenditure))
        acquisitionsAndDisposals.append(getValueFrom(stringValue: item.acquisitionsAndDisposals))
        investmentPurchasesAndSales.append(getValueFrom(stringValue: item.investmentPurchasesAndSales))
        
        investingCashFlow.append(getValueFrom(stringValue: item.investingCashFlow))
        issuanceRepaymentOfDebt.append(getValueFrom(stringValue: item.issuanceRepaymentOfDebt))
        issuanceBuybacksOfShares.append(getValueFrom(stringValue: item.issuanceBuybacksOfShares))
        dividendPayments.append(getValueFrom(stringValue: item.dividendPayments))
        financingCashFlow.append(getValueFrom(stringValue: item.financingCashFlow))
        effectOfForexChangesOnCash.append(getValueFrom(stringValue: item.effectOfForexChangesOnCash))
        netCashFlowChangeInCash.append(getValueFrom(stringValue: item.netCashFlowChangeInCash))
        freeCashFlow.append(getValueFrom(stringValue: item.freeCashFlow))
        netCashMarketcap.append(getValueFrom(stringValue: item.netCashMarketcap))
    }
    mutating func getStatementItems()->[SCCompanyStatementItem]{
        var statementItems = [SCCompanyStatementItem]()
        let values = [depreciationAmortization, stockBasedCompensation,
                    operatingCashFlow,capitalExpenditure,
                    acquisitionsAndDisposals,investmentPurchasesAndSales,
                    investingCashFlow,issuanceRepaymentOfDebt,
                    issuanceBuybacksOfShares,dividendPayments,financingCashFlow,
                    effectOfForexChangesOnCash,netCashFlowChangeInCash,
                    freeCashFlow,netCashMarketcap]
        
        for (index,title) in titles.enumerated(){
            statementItems.append(SCCompanyStatementItem(name: title, values: values[index]))
        }
        return statementItems
    }
    
    func getValueFrom(stringValue: String?)->Double{
        let value = Double(stringValue ?? "0") ?? 0
        return value.rounded(toPlaces: 2)
    }
}
