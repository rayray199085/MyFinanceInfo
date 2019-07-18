//
//  SCCompanyISViewModels.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyISViewModels {
    private let titles = ["Revenue", "Revenue Growth", "Cost of Revenue",
                  "Gross Profit","R&D Expenses","SG&A Expense",
                  "Operating Expenses","Operating Income","Interest Expense",
                  "Earnings before Tax","Income Tax Expense","Net Income",
                  "Net Income - Non-Controlling int","Net Income - Discontinued ops",
                  "Net Income Com","Preferred Dividends","EPS","EPS Diluted",
                  "Weighted Average Shs Out",
                  "Weighted Average Shs Out (Dil)",
                  "Dividend per Share","Gross Margin",
                  "EBITDA Margin","EBIT Margin",
                  "Profit Margin","Free Cash Flow margin",
                  "EBITDA","EBIT","Consolidated Income",
                  "Earnings Before Tax Margin","Net Profit Margin"]
    var date = [String]()
    private var revenue = [Double]()
    private var revenueGrowth = [Double]()
    private var costOfRevenue = [Double]()
    private var grossProfit = [Double]()
    private var rdExpenses = [Double]()
    private var sgaExpense = [Double]()

    private var operatingExpenses = [Double]()
    private var operatingIncome = [Double]()
    private var interestExpense = [Double]()
    private var earningsBeforeTax = [Double]()
    private var incomeTaxExpense = [Double]()
    private var netIncomeNonControllingInt = [Double]()
    private var netIncomeDiscontinuedOps = [Double]()
    private var netIncome = [Double]()
    private var preferredDividends = [Double]()
    private var netIncomeCom = [Double]()
    private var eps = [Double]()
    private var epsDiluted = [Double]()

    private var weightedAverageShsOut = [Double]()
    private var weightedAverageShsOutDil = [Double]()
    private var dividendPerShare = [Double]()
    private var grossMargin = [Double]()

    private var eBITDAMargin = [Double]()
    private var eBITMargin = [Double]()
    private var profitMargin = [Double]()
    private var freeCashFlowMargin = [Double]()
    private var eBITDA = [Double]()
    private var eBIT = [Double]()
    private var consolidatedIncome = [Double]()
    private var earningsBeforeTaxMargin = [Double]()
    private var netProfitMargin = [Double]()
    
    mutating func setValues(item: SCCompanyIncomeFinancialItem){
        date.append(((item.date ?? "") as NSString).substring(with: NSRange(location: 0, length: 4)))
        revenue.append(getValueFrom(stringValue: item.revenue))
        revenueGrowth.append(getValueFrom(stringValue: item.revenueGrowth))
        costOfRevenue.append(getValueFrom(stringValue: item.costOfRevenue))
        grossProfit.append(getValueFrom(stringValue: item.grossProfit))
        rdExpenses.append(getValueFrom(stringValue: item.rdExpenses))
        sgaExpense.append(getValueFrom(stringValue: item.sgaExpense))
        
        operatingExpenses.append(getValueFrom(stringValue: item.operatingExpenses))
        operatingIncome.append(getValueFrom(stringValue: item.operatingIncome))
        interestExpense.append(getValueFrom(stringValue: item.interestExpense))
        earningsBeforeTax.append(getValueFrom(stringValue: item.earningsBeforeTax))
        incomeTaxExpense.append(getValueFrom(stringValue: item.incomeTaxExpense))
        netIncomeNonControllingInt.append(getValueFrom(stringValue: item.netIncomeNonControllingInt))
        netIncomeDiscontinuedOps.append(getValueFrom(stringValue: item.netIncomeDiscontinuedOps))
        netIncome.append(getValueFrom(stringValue: item.netIncome))
        preferredDividends.append(getValueFrom(stringValue: item.preferredDividends))
        netIncomeCom.append(getValueFrom(stringValue: item.netIncomeCom))
        eps.append(getValueFrom(stringValue: item.eps))
        epsDiluted.append(getValueFrom(stringValue: item.epsDiluted))
        
        weightedAverageShsOut.append(getValueFrom(stringValue: item.weightedAverageShsOut))
        weightedAverageShsOutDil.append(getValueFrom(stringValue: item.weightedAverageShsOutDil))
        dividendPerShare.append(getValueFrom(stringValue: item.dividendPerShare))
        grossMargin.append(getValueFrom(stringValue: item.grossMargin))
        
        eBITDAMargin.append(getValueFrom(stringValue: item.eBITDAMargin))
        eBITMargin.append(getValueFrom(stringValue: item.eBITMargin))
        profitMargin.append(getValueFrom(stringValue: item.profitMargin))
        freeCashFlowMargin.append(getValueFrom(stringValue: item.freeCashFlowMargin))
        eBITDA.append(getValueFrom(stringValue: item.eBITDA))
        eBIT.append(getValueFrom(stringValue: item.eBIT))
        consolidatedIncome.append(getValueFrom(stringValue: item.consolidatedIncome))
        earningsBeforeTaxMargin.append(getValueFrom(stringValue: item.earningsBeforeTaxMargin))
        netProfitMargin.append(getValueFrom(stringValue: item.netProfitMargin))
    }
    
    mutating func getStatementItems()->[SCCompanyStatementItem]{
        var statementItems = [SCCompanyStatementItem]()
        let values = [revenue, revenueGrowth, costOfRevenue,
                      grossProfit, rdExpenses, sgaExpense,
                      operatingExpenses,operatingIncome, interestExpense,
                      earningsBeforeTax, incomeTaxExpense,netIncome,
                      netIncomeNonControllingInt,netIncomeDiscontinuedOps,
                      netIncomeCom,preferredDividends,
                      eps, epsDiluted,weightedAverageShsOut, weightedAverageShsOutDil,
                      dividendPerShare,grossMargin, eBITDAMargin, eBITMargin,
                      profitMargin, freeCashFlowMargin,eBITDA,eBIT,
                      consolidatedIncome,earningsBeforeTaxMargin,netProfitMargin]

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
