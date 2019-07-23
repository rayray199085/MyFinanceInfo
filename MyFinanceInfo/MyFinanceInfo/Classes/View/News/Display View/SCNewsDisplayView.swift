//
//  SCNewsDisplayView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SCRRefreshControl

protocol SCNewsDisplayViewDelegate: NSObjectProtocol {
    func didDragToBottom(view: SCNewsDisplayView, willShowPageNumber: Int)
    func didPullToRefresh(view: SCNewsDisplayView,completion:@escaping ()->())
    func didSelectCell(view: SCNewsDisplayView, index: Int)
}
private let reuseableIdentifier = "article_cell"
class SCNewsDisplayView: UIView {
    weak var delegate: SCNewsDisplayViewDelegate?
    private lazy var refreshControl = SCRRefreshControl(style: .simple)
    var currentPage = 1
    var shouldPullUp: Bool = false
    
    var listViewModel: SCNewsListViewModel?
    
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
    @objc private func pullToRefresh(){
        if listViewModel?.currentSegmentName == nil{
            refreshControl.endRefreshing()
            return
        }
        refreshControl.beginRefreshing()
        delegate?.didPullToRefresh(view: self, completion: { [weak self] in
            self?.refreshControl.endRefreshing()
        })
    }
}
private extension SCNewsDisplayView{
    func setupUI(){
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SCNewsHeadlineCell", bundle: nil), forCellReuseIdentifier: reuseableIdentifier)
    }
}
extension SCNewsDisplayView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = listViewModel?.viewModels?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseableIdentifier, for: indexPath) as! SCNewsHeadlineCell
        cell.viewModel = listViewModel?.viewModels?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listViewModel?.viewModels?[indexPath.row].rowHeight ?? 0
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        // let currentSection == indexPath.section
        let section = tableView.numberOfSections - 1
        if row < 0 || section < 0{
            return
        }
        let rowCount = tableView.numberOfRows(inSection: section)
        
        if row == (rowCount - 1) && !shouldPullUp && (listViewModel?.totalArticles ?? 0) > currentPage * 20{
            shouldPullUp = true
            currentPage += 1
            delegate?.didDragToBottom(view: self, willShowPageNumber: currentPage)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCell(view: self, index: indexPath.row)
    }
}

