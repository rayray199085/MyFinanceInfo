//
//  SCNewsDisplayView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

private let reuseableIdentifier = "article_cell"
class SCNewsDisplayView: UIView {
    var viewModels: [SCNewsArticleViewModel]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    class func displayView()->SCNewsDisplayView{
        let nib = UINib(nibName: "SCNewsDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCNewsDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}
private extension SCNewsDisplayView{
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SCNewsHeadlineCell", bundle: nil), forCellReuseIdentifier: reuseableIdentifier)
    }
}
extension SCNewsDisplayView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModels?.count ?? 0
        tableView.hideSeparatorWhenEmpty(count: count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseableIdentifier, for: indexPath) as! SCNewsHeadlineCell
        cell.viewModel = viewModels?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModels?[indexPath.row].rowHeight ?? 0
    }
}

