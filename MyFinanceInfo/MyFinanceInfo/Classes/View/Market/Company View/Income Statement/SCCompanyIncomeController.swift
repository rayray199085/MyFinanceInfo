//
//  SCCompanyIncomeController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCCompanyIncomeController: SCCompanyStatementController {
    
    override func loadData() {
        if listViewModel?.incomeStatementItems != nil{
            return 
        }
        guard let ticker = parent?.title else{
            return
        }
        SVProgressHUD.show()
        listViewModel?.loadIncomeStatement(ticker: ticker, completion: { [weak self](isSuccess) in
            self?.dataDisplayView.statementItems = self?.listViewModel?.incomeStatementItems
            self?.dataView.date = self?.listViewModel?.date
            SVProgressHUD.dismiss()
        })
    }
}
