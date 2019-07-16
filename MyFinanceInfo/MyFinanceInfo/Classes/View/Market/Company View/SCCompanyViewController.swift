//
//  SCCompanyViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 16/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import DLSlideView

class SCCompanyViewController: UIViewController {
    private let tabInfoArray = [["image":"about", "title": "About"],
                            ["image":"income", "title": "I/S"],
                            ["image":"balanceSheet", "title": "B/S"],
                            ["image":"cashFlow", "title": "CFS"]]
    
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
}

private extension SCCompanyViewController{
    func setupUI(){
        setupTabedSlideView()
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
}
extension SCCompanyViewController: DLTabedSlideViewDelegate{
    func numberOfTabs(in sender: DLTabedSlideView!) -> Int {
        return 4
    }
    
    func dlTabedSlideView(_ sender: DLTabedSlideView!, controllerAt index: Int) -> UIViewController? {
        return UIViewController()
    }
    func dlTabedSlideView(_ sender: DLTabedSlideView!, didSelectedAt index: Int) {
        
    }
}

