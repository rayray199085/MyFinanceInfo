//
//  SCNewsContentController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 22/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCNewsContentController: UIViewController {
    var listViewModel: SCNewsListViewModel?
    private lazy var displayView = SCNewsDisplayView.displayView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if view.frame.origin.y == 0{
            displayView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 34, right: 0)
        }else{
             displayView.tableView.contentInset = UIEdgeInsets.zero
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func loadData(segmentName: String){
        if listViewModel?.currentSegmentName == segmentName{
            return
        }
        SVProgressHUD.show()
        listViewModel?.loadTopHeadlines(segmentName: segmentName, completion: { [weak self](isSuccess) in
            self?.displayView.viewModels = self?.listViewModel?.viewModels
            SVProgressHUD.dismiss()
        })
    }
}
private extension SCNewsContentController{
    func setupUI(){
        view.addSubview(displayView)
    }
}
