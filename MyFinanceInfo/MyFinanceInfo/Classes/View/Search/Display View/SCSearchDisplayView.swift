//
//  SCSearchDisplayView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 20/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SCTableIndex

protocol SCSearchDisplayViewDelegate: NSObjectProtocol {
    func didSelectedCell(view: SCSearchDisplayView?, ticker: String?)
}
private let reuseIdentifier = "company_cell"
class SCSearchDisplayView: UIView {
    weak var delegate: SCSearchDisplayViewDelegate?
    
    var viewModels: [SCSearchViewModel]?{
        didSet{
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableIndex: SCTableIndex!
    class func displayView()->SCSearchDisplayView{
        let nib = UINib(nibName: "SCSearchDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCSearchDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SCSearchCompanyCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        tableIndex.delegate = self
        tableIndex.initialFont = UIFont.boldSystemFont(ofSize: 13)
        tableIndex.initialTextColor = InfoCommon.tinColor
    }
}
extension SCSearchDisplayView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModels?.count ?? 0
        tableView.hideSeparatorWhenEmpty(count: count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCSearchCompanyCell
        cell.displayTextLabel.text = viewModels?[indexPath.row].displayText
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModels?[indexPath.row].rowHeight ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedCell(view: self,ticker: viewModels?[indexPath.row].ticker)
    }
}
extension SCSearchDisplayView: SCTableIndexDelegate{
    func scTableIndexReturnInitialText(_ strInitial: String, index: Int) {
        tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
    }
}
