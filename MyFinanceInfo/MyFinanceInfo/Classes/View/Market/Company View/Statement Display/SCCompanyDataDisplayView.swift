//
//  SCCompanyDataDisplayView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCCompanyDataDisplayViewDelegate: NSObjectProtocol {
    func didSelectedCell(view: SCCompanyDataDisplayView, item: SCCompanyStatementItem?)
}
private let reuseIdentifier = "statement_cell"
class SCCompanyDataDisplayView: UIView {
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SCCompanyDataDisplayViewDelegate?
    
    var statementItems: [SCCompanyStatementItem]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    class func dataDisplayView()->SCCompanyDataDisplayView{
        let nib = UINib(nibName: "SCCompanyDataDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCCompanyDataDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
extension SCCompanyDataDisplayView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemCount = statementItems?.count ?? 0
        tableView.hideSeparatorWhenEmpty(count: itemCount)
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = statementItems?[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedCell(view: self, item: statementItems?[indexPath.row])
    }
}
