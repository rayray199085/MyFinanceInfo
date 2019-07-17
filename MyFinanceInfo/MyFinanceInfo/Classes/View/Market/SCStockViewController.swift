//
//  SCMarketViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCMarketViewController: UIViewController {
    private let categoryView = SCStockCategoryView.categoryView()
    private let displayView = SCStockDisplayView.displayView()
    private let listViewModel = SCStockListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func clickSearchButton(){
        navigationItem.leftBarButtonItem?.isEnabled = false
        if categoryView.frame.origin.x == -UIScreen.screenWidth(){
            categoryView.showCategoryView {[weak self] in
                self?.navigationItem.leftBarButtonItem?.isEnabled = true
            }
        }else{
            categoryView.hideCategoryView { [weak self](index) in
                self?.navigationItem.leftBarButtonItem?.isEnabled = true
                self?.loadData(index: index)
            }
        }
    }
    func loadData(index: Int){
        if index == listViewModel.previewIndex{
            return 
        }
        SVProgressHUD.show()
        listViewModel.loadStockData(index: index) { [weak self](isSuccess) in
            self?.displayView.tableView.reloadData()
            self?.displayView.tableView.scroll(to: UITableView.scrollsTo.top, animated: true)
            SVProgressHUD.dismiss()
        }
    }
}
private extension SCMarketViewController{
    func setupUI(){
        view.addSubview(displayView)
        displayView.listViewModel = listViewModel
        displayView.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(clickSearchButton))
        view.addSubview(categoryView)
        categoryView.frame.origin.x = -UIScreen.screenWidth()
        categoryView.delegate = self
    }
}
extension SCMarketViewController: SCStockCategoryViewDelegate{
    func didClickCategoryMaskButton(view: SCStockCategoryView?, index: Int) {
        loadData(index: index)
    }
}
extension SCMarketViewController: SCStockDisplayViewDelegate{
    func didSelectedCompany(view: SCStockDisplayView, ticker: String) {
        let vc = SCCompanyViewController()
        vc.title = ticker
        vc.listViewModel = listViewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didPullRefreshControl(view: SCStockDisplayView, completion: @escaping () -> ()) {
        listViewModel.loadStockData(index: listViewModel.previewIndex) { [weak self](isSuccess) in
            self?.displayView.tableView.reloadData()
            completion()
        }
    }
}
