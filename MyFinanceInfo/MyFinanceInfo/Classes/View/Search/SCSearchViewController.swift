//
//  SCSearchViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCSearchViewController: UIViewController {
    private let listViewModel = SCSearchListViewModel()
    private let displayView = SCSearchDisplayView.displayView()
    private let searchHistoryView = SCSearchHistoryView.historyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    @objc private func clickHistoryRecordButton(){
        navigationItem.leftBarButtonItem?.isEnabled = false
        if searchHistoryView.frame.origin.x == -UIScreen.screenWidth(){
            searchHistoryView.showSearchHistoryRecord()
            searchHistoryView.showSearchHistoryView { [weak self] in
                self?.navigationItem.leftBarButtonItem?.isEnabled = true
            }
        }else{
            searchHistoryView.hideSearchHistoryView { [weak self] in
                self?.navigationItem.leftBarButtonItem?.isEnabled = true
                self?.selectHistoryRecord()
            }
        }
    }
    private func selectHistoryRecord(){
        viewCompanyDetails(ticker: searchHistoryView.selectedTicker)
        searchHistoryView.selectedTicker = nil
    }
    private func viewCompanyDetails(ticker: String?){
        guard let ticker = ticker else{
            return
        }
        saveSearchHistory(ticker: ticker)
        
        let vc = SCCompanyViewController()
        vc.title = ticker
        vc.listViewModel = listViewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}
private extension SCSearchViewController{
    func setupUI(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImageName: "historyRecord", highlightedImageName: "historyRecord_highlighted", target: self, action: #selector(clickHistoryRecordButton))
        
        view.addSubview(displayView)
        displayView.delegate = self
        
        view.addSubview(searchHistoryView)
        searchHistoryView.frame.origin.x = -UIScreen.screenWidth()
        searchHistoryView.delegate = self
    }
    func loadData(){
        SVProgressHUD.show()
        listViewModel.loadCompanyList { [weak self](isSuccess) in
            self?.displayView.viewModels = self?.listViewModel.searchViewModels
            if let nameList = self?.listViewModel.nameList {
                self?.displayView.tableIndex.setView(nameList)
            }
            SVProgressHUD.dismiss()
        }
    }
}
extension SCSearchViewController: SCSearchDisplayViewDelegate{
    func didSelectedCell(view: SCSearchDisplayView?, ticker: String?) {
        viewCompanyDetails(ticker: ticker)
    }
}
private extension SCSearchViewController{
    func saveSearchHistory(ticker: String){
        if let _ = CoreDataManager.shared.getCompanyWith(ticker: ticker).first{
            CoreDataManager.shared.updateCompanySearchFrequencyWith(ticker: ticker)
        }else{
            CoreDataManager.shared.addCompanyWith(ticker: ticker, searchFrequency: 1)
        }
    }
}
extension SCSearchViewController: SCSearchHistoryViewDelegate{
    func didClickMaskButton(view: SCSearchHistoryView?) {
        selectHistoryRecord()
    }
}
