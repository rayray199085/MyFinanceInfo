//
//  SCIndexesDisplayView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
private let reuseIdentifier = "indexes_cell"
class SCIndexesDisplayView: UIView {
    var viewModels: [SCIndexesViewModel]?{
        didSet{
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    class func displayView()->SCIndexesDisplayView{
        let nib = UINib(nibName: "SCIndexesDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCIndexesDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SCIndexesTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
}
extension SCIndexesDisplayView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModels?.count ?? 0
        tableView.hideSeparatorWhenEmpty(count: count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCIndexesTableViewCell
        cell.viewModel = viewModels?[indexPath.row]
        return cell
    }
    
    
}
