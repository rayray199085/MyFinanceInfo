//
//  SCStockCategoryView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCStockCategoryViewDelegate: NSObjectProtocol {
    func didSelectedHideCategory(view: SCStockCategoryView?, index: Int)
}
private let reuseIdentifier = "category_cell"
class SCStockCategoryView: UIView {
    weak var delegate: SCStockCategoryViewDelegate?
    
    private var selectedIndex: Int = -1
    
    private let headers = ["Info","Data"]
    private let titles = ["Actives","Gainers","Losers","Currencies","Cryptocurrency","Sector Performance"]
    class func categoryView()->SCStockCategoryView{
        let nib = UINib(nibName: "SCStockCategoryView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCStockCategoryView
        v.frame = UIScreen.main.bounds
        return v
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func clickCategoryMaskButton(_ sender: Any) {
        hideCategoryView { [weak self](index) in
           self?.delegate?.didSelectedHideCategory(view: self, index: index)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
extension SCStockCategoryView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count / headers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = titles[indexPath.section * 3 + indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.section * 3 + indexPath.row
    }
}
extension SCStockCategoryView{
    func showCategoryView(completion:@escaping ()->()){
        addPopHorizontalAnimation(fromValue: -UIScreen.screenWidth() / 2, toValue: UIScreen.screenWidth() / 2, springBounciness: 8, springSpeed: 8, delay: 0) { (_, _) in
            completion()
        }
    }
    func hideCategoryView(completion:@escaping (_ selectedIndex: Int)->()){
        addPopHorizontalAnimation(fromValue: UIScreen.screenWidth() / 2, toValue: -UIScreen.screenWidth() / 2, springBounciness: 8, springSpeed: 8, delay: 0) {[weak self] (_, _) in
            completion(self?.selectedIndex ?? 0)
        }
    }
}
