//
//  SCCompanyCashFlowController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import SVProgressHUD

class SCCompanyCashFlowController: SCCompanyStatementController {
    
    override func loadData() {
        if listViewModel?.cashFlowtStatementItems != nil{
            dataDisplayView.tableView.scroll(to: UITableView.scrollsTo.top, animated: true)
            return
        }
        guard let ticker = parent?.title else{
            return
        }
        SVProgressHUD.show()
        listViewModel?.loadCashFlowStatement(ticker: ticker, completion: { [weak self](isSuccess) in
            self?.dataDisplayView.statementItems = self?.listViewModel?.cashFlowtStatementItems
            self?.dataView.date = self?.listViewModel?.cfDate
            SVProgressHUD.dismiss()
        })
    }
    
}
