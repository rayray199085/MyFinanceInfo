//
//  SCCompanyBSViewModels.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyBSViewModels {
    private let titles = ["Cash and cash equivalents","Short-term investments",
                          "Cash and short-term investments","Receivables",
                          "Inventories","Property, Plant & Equipment Net",
                          "Goodwill and Intangible Assets","Long-term investments",
                          "Tax assets","Total non-current assets","Total current assets",
                          "Total assets","Payables", "Short-term debt",
                          "Total current liabilities","Long-term debt",
                          "Total debt","Deferred revenue",
                          "Tax Liabilities","Deposit Liabilities","Total non-current liabilities",
                          "Total liabilities","Other comprehensive income","Retained earnings (deficit)",
                          "Total shareholders equity","Investments","Net Debt",
                          "Other Assets", "Other Liabilities"]
    var date = [String]()
    private var cashAndCashEquivalents = [Double]()
    private var shortTermInvestments = [Double]()
    private var cashAndShortTermInvestments = [Double]()
    private var receivables = [Double]()
    private var inventories = [Double]()

    private var propertyPlantEquipmentNet = [Double]()
    private var goodWillAndIntangibleAssets = [Double]()
    private var longTermInvestments = [Double]()
    private var taxAssets = [Double]()
    private var totalNonCurrentAssets = [Double]()
    private var totalCurrentAssets = [Double]()
    private var totalAssets = [Double]()
    private var payablest = [Double]()
    private var shortTermDebt = [Double]()
    private var totalCurrentLiabilities = [Double]()

    private var longTermDebt = [Double]()
    private var totalDebt = [Double]()
    private var deferredRevenue = [Double]()

    private var taxLiabilities = [Double]()
    private var depositLiabilities = [Double]()
    private var totalNonCurrentLiabilities = [Double]()
    private var totalLiabilities = [Double]()
    
    private var otherComprehensiveIncome = [Double]()
    private var retainedEarningsDeficit = [Double]()
    private var totalShareholdersEquity = [Double]()
    private var investments = [Double]()
    private var netDebt = [Double]()
    private var otherAssets = [Double]()
    private var otherLiabilities = [Double]()
    
    mutating func setValues(item: SCCompanyBalanceFinancialItem) {
        date.append(((item.date ?? "") as NSString).substring(with: NSRange(location: 0, length: 4)))
        cashAndCashEquivalents.append(getValueFrom(stringValue: item.cashAndCashEquivalents))
        shortTermInvestments.append(getValueFrom(stringValue: item.shortTermInvestments))
        cashAndShortTermInvestments.append(getValueFrom(stringValue: item.cashAndShortTermInvestments))
        receivables.append(getValueFrom(stringValue: item.receivables))
        inventories.append(getValueFrom(stringValue: item.inventories))
        totalCurrentAssets.append(getValueFrom(stringValue: item.totalCurrentAssets))
        
        propertyPlantEquipmentNet.append(getValueFrom(stringValue: item.propertyPlantEquipmentNet))
        goodWillAndIntangibleAssets.append(getValueFrom(stringValue: item.goodWillAndIntangibleAssets))
        longTermInvestments.append(getValueFrom(stringValue: item.longTermInvestments))
        taxAssets.append(getValueFrom(stringValue: item.taxAssets))
        totalNonCurrentAssets.append(getValueFrom(stringValue: item.totalNonCurrentAssets))
        totalAssets.append(getValueFrom(stringValue: item.totalAssets))
        
        payablest.append(getValueFrom(stringValue: item.payablest))
        shortTermDebt.append(getValueFrom(stringValue: item.shortTermDebt))
        totalCurrentLiabilities.append(getValueFrom(stringValue: item.totalCurrentLiabilities))
        
        longTermDebt.append(getValueFrom(stringValue: item.longTermDebt))
        totalDebt.append(getValueFrom(stringValue: item.totalDebt))
        deferredRevenue.append(getValueFrom(stringValue: item.deferredRevenue))
        
        taxLiabilities.append(getValueFrom(stringValue: item.taxLiabilities))
        depositLiabilities.append(getValueFrom(stringValue: item.depositLiabilities))
        totalNonCurrentLiabilities.append(getValueFrom(stringValue: item.totalNonCurrentLiabilities))
        totalLiabilities.append(getValueFrom(stringValue: item.totalLiabilities))
        
        otherComprehensiveIncome.append(getValueFrom(stringValue: item.otherComprehensiveIncome))
        retainedEarningsDeficit.append(getValueFrom(stringValue: item.retainedEarningsDeficit))
        totalShareholdersEquity.append(getValueFrom(stringValue: item.totalShareholdersEquity))
        investments.append(getValueFrom(stringValue: item.investments))
        netDebt.append(getValueFrom(stringValue: item.netDebt))
        otherAssets.append(getValueFrom(stringValue: item.otherAssets))
        otherLiabilities.append(getValueFrom(stringValue: item.otherLiabilities))
    }
    mutating func getStatementItems()->[SCCompanyStatementItem]{
        var statementItems = [SCCompanyStatementItem]()
        let values = [cashAndCashEquivalents,shortTermInvestments,
                      cashAndShortTermInvestments,receivables,
                      inventories,propertyPlantEquipmentNet,
                      goodWillAndIntangibleAssets,longTermInvestments,
                      taxAssets,totalNonCurrentAssets,totalCurrentAssets,
                      totalAssets,payablest,shortTermDebt,
                      totalCurrentLiabilities,longTermDebt,totalDebt,
                      deferredRevenue,taxLiabilities,depositLiabilities,
                      totalNonCurrentLiabilities,totalLiabilities,
                      otherComprehensiveIncome,retainedEarningsDeficit,
                      totalShareholdersEquity,investments,
                      netDebt,otherAssets,otherLiabilities]
        
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
