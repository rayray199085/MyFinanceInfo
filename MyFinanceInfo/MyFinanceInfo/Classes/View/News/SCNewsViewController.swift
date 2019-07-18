//
//  SCNewsViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import WebKit
import SVProgressHUD

class SCNewsViewController: UIViewController {
    private lazy var displayView = SCNewsDisplayView.displayView()
    private let listViewModel = SCNewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}
private extension SCNewsViewController{
    func setupUI(){
        view.addSubview(displayView)
    }
    func loadData(){
        SVProgressHUD.show()
        listViewModel.loadTopHeadlines { (isSuccess) in
            SVProgressHUD.dismiss()
        }
    }
}
