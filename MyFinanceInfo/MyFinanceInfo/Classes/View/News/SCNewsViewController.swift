//
//  SCNewsViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD
import BTNavigationDropdownMenu

class SCNewsViewController: UIViewController {
    private let displayView = SCNewsDisplayView.displayView()
    private let titles = ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
    private let listViewModel = SCNewsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMenuView()
    }
}
private extension SCNewsViewController{
    func setupUI(){
        view.addSubview(displayView)
        displayView.listViewModel = listViewModel
        displayView.delegate = self
    }
    func setupMenuView(){
        let menuView = BTNavigationDropdownMenu(navigationController: navigationController, containerView: navigationController!.view, title: BTTitle.title("News Category Menu"), items: titles)
        navigationItem.titleView = menuView
        menuView.navigationBarTitleFont = UIFont.boldSystemFont(ofSize: 18)
        menuView.cellBackgroundColor = .white
        menuView.cellTextLabelFont = UIFont.systemFont(ofSize: 17)
        menuView.maskBackgroundOpacity = 0.8
        menuView.didSelectItemAtIndexHandler = {[weak self](indexPath: Int) -> () in
            let segmentName = self?.titles[indexPath].lowercased()
            if self?.listViewModel.currentSegmentName == segmentName{
                return
            }
            self?.loadNewHeadlines(segmentName: segmentName)
        }
    }
    func loadNewHeadlines(segmentName: String?,completion: (()->())? = nil){
        guard let segmentName = segmentName else{
            return
        }
        listViewModel.viewModels = nil
        displayView.currentPage = 1
        SVProgressHUD.show()
        listViewModel.loadTopHeadlines(segmentName: segmentName) {[weak self] (isSuccess) in
            self?.displayView.tableView.reloadData()
            self?.displayView.tableView.scroll2Top()
            if let completion = completion{
                completion()
            }
            SVProgressHUD.dismiss()
        }
    }
}
extension SCNewsViewController: SCNewsDisplayViewDelegate{
    func didSelectCell(view: SCNewsDisplayView, index: Int) {
        let vc = SCNewsContentController()
        vc.viewModel = listViewModel.viewModels?[index]
        vc.title = "Details"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didPullToRefresh(view: SCNewsDisplayView, completion: @escaping () -> ()) {
        loadNewHeadlines(segmentName: listViewModel.currentSegmentName) {
            completion()
        }
    }
    
    func didDragToBottom(view: SCNewsDisplayView, willShowPageNumber: Int) {
        SVProgressHUD.show()
        listViewModel.loadTopHeadlines(pageIndex: willShowPageNumber,segmentName: listViewModel.currentSegmentName!) {[weak self] (isSuccess) in
            self?.displayView.tableView.reloadData()
            self?.displayView.shouldPullUp = false
            SVProgressHUD.dismiss()
        }
    }
}
