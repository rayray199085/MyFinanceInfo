//
//  SCCompanyViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 16/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import DLSlideView
import SVProgressHUD

class SCCompanyViewController: UIViewController {
    private lazy var historicalPriceView = SCCompanyHistoricalPriceView.historicalPriceView()
    var listViewModel: SCStockListViewModel?{
        didSet{
            loadData()
        }
    }
    
    private let tabInfoArray = [["image":"about", "title": "About"],
                            ["image":"income", "title": "I/S"],
                            ["image":"balanceSheet", "title": "B/S"],
                            ["image":"cashFlow", "title": "CFS"]]
    private let aboutController = UIStoryboard(name: "SCCompanyAboutController", bundle: nil).instantiateViewController(withIdentifier: "company_about") as! SCCompanyAboutController
    private let incomeController = SCCompanyIncomeController()
    private let balanceController = SCCompanyBalanceController()
    private let cashFlowController = SCCompanyCashFlowController()
    
    @IBOutlet weak var tabedSlideView: DLTabedSlideView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func getTabs()->[DLTabedbarItem]{
        var tabs = [DLTabedbarItem]()
        for dict in tabInfoArray{
            guard let imageName = dict["image"],
                let title = dict["title"],
                let normalImage = UIImage(named: imageName)?.modifyImageSize(newSize: CGSize(width: 20, height: 20)),
                let highlightedImage = UIImage(named: "\(imageName)_highlighted")?.modifyImageSize(newSize: CGSize(width: 20, height: 20)),
                let tabItem = DLTabedbarItem(title: title, image: normalImage, selectedImage: highlightedImage) else{
                    return tabs
            }
            tabs.append(tabItem)
        }
        return tabs
    }
    
    deinit {
        listViewModel?.clearCompanyContent()
    }
    @objc private func clickHistoryButton(){
        guard let title = title else{
            return
        }
        navigationItem.rightBarButtonItem?.isEnabled = false
        if listViewModel?.historyViewModels != nil{
            showHistoricalPriceView()
            return
        }
        SVProgressHUD.show()
        listViewModel?.loadFullHistoricalPrice(ticker: title, completion: { [weak self](isSuccess) in
            SVProgressHUD.dismiss()
            self?.historicalPriceView.historyViewModels = self?.listViewModel?.historyViewModels
            self?.showHistoricalPriceView()
        })
        
    }
    func showHistoricalPriceView(){
        historicalPriceView.show { [weak self] in
            self?.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

private extension SCCompanyViewController{
    func setupUI(){
        setupTabedSlideView()
        setupNavigationItem()
    }
    
    func setupNavigationItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "History", fontSize: 16, target: self, action: #selector(clickHistoryButton), isBack: false)
        navigationController?.view.addSubview(historicalPriceView)
        historicalPriceView.frame.origin.x = UIScreen.screenWidth()
    }
    func setupTabedSlideView(){
        tabedSlideView.baseViewController = self
        tabedSlideView.delegate = self
        tabedSlideView.tabItemNormalColor = UIColor.darkGray
        tabedSlideView.tabItemSelectedColor = InfoCommon.tinColor
        tabedSlideView.tabbarTrackColor = InfoCommon.tinColor
        tabedSlideView.tabbarBottomSpacing = 3.0
        
        tabedSlideView.tabbarItems = getTabs()
        tabedSlideView.buildTabbar()
        tabedSlideView.selectedIndex = 0
    }
    
    func loadData(){
        guard let ticker = title else{
            return
        }
        SVProgressHUD.show()
        listViewModel?.loadCompanyInfo(ticker: ticker, completion: { [weak self](isSuccess) in
            self?.aboutController.listViewModel = self?.listViewModel
            SVProgressHUD.dismiss()
        })
    }
}
extension SCCompanyViewController: DLTabedSlideViewDelegate{
    func numberOfTabs(in sender: DLTabedSlideView!) -> Int {
        return 4
    }
    
    func dlTabedSlideView(_ sender: DLTabedSlideView!, controllerAt index: Int) -> UIViewController? {
        switch index {
        case 0:
            return aboutController
        case 1:
            return incomeController
        case 2:
            return balanceController
        case 3:
            return cashFlowController
        default:
            break
        }
        return UIViewController()
    }
    func dlTabedSlideView(_ sender: DLTabedSlideView!, didSelectedAt index: Int) {
        switch index {
        case 1:
            incomeController.listViewModel = listViewModel
        case 2:
            balanceController.listViewModel = listViewModel
        case 3:
            cashFlowController.listViewModel = listViewModel
        default:
            break
        }
    }
}

