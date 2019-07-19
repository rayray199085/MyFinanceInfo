//
//  SCIndexesViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCIndexesViewController: UIViewController {
    private let listViewModel = SCIndexesListViewModel()
    private let displayView = SCIndexesDisplayView.displayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(displayView)
        loadData()
    }

}
private extension SCIndexesViewController{
    func loadData(){
        SVProgressHUD.show()
        listViewModel.loadMajorIndexes { [weak self](isSuccess) in
            self?.displayView.viewModels = self?.listViewModel.viewModels
            SVProgressHUD.dismiss()
        }
    }
}
