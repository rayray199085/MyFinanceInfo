//
//  SCCompanyStatementController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCompanyStatementController: UIViewController {
    let dataDisplayView = SCCompanyDataDisplayView.dataDisplayView()
    let dataView = SCCompanyStatementDataView.dataView()
    
    var listViewModel: SCBaseListViewModel?{
        didSet{
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func loadData(){
        
    }
}
private extension SCCompanyStatementController{
    func setupUI(){
        view.addSubview(dataDisplayView)
        dataDisplayView.delegate = self
        parent?.navigationController?.view.addSubview(dataView)
        dataView.isHidden = true
    }
}
extension SCCompanyStatementController: SCCompanyDataDisplayViewDelegate{
    func didSelectedCell(view: SCCompanyDataDisplayView, item: SCCompanyStatementItem?) {
        dataView.item = item
        dataView.isHidden = false
    }
}
