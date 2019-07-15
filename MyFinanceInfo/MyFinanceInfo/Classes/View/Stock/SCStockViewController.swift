//
//  SCStockViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCStockViewController: UIViewController {
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
private extension SCStockViewController{
    func setupUI(){
        view.addSubview(displayView)
        displayView.listViewModel = listViewModel
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(clickSearchButton))
        view.addSubview(categoryView)
        categoryView.frame.origin.x = -UIScreen.screenWidth()
        categoryView.delegate = self
    }
}
extension SCStockViewController: SCStockCategoryViewDelegate{
    func didSelectedHideCategory(view: SCStockCategoryView?, index: Int) {
        loadData(index: index)
    }
}
