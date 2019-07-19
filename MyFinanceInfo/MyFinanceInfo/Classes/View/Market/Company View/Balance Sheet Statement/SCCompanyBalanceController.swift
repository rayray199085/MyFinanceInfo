//
//  SCCompanyBalanceController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCCompanyBalanceController: SCCompanyStatementController {

    override func loadData() {
        if listViewModel?.balanceSheetStatementItems != nil{
            dataDisplayView.tableView.scroll(to: UITableView.scrollsTo.top, animated: true)
            return
        }
        guard let ticker = parent?.title else{
            return
        }
        SVProgressHUD.show()
        listViewModel?.loadBalanceSheetStatement(ticker: ticker, completion: { [weak self](isSuccess) in
            self?.dataDisplayView.statementItems = self?.listViewModel?.balanceSheetStatementItems
            self?.dataView.date = self?.listViewModel?.bsDate
            SVProgressHUD.dismiss()
        })
    }

}
