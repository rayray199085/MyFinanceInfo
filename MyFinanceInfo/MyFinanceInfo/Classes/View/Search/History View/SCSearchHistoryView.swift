//
//  SCSearchHistoryView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 20/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
protocol SCSearchHistoryViewDelegate: NSObjectProtocol {
    func didClickMaskButton(view: SCSearchHistoryView?)
}
private let reuseIdtifier = "company_cell"
class SCSearchHistoryView: UIView {
    weak var delegate: SCSearchHistoryViewDelegate?
    
    private var companies: [Company]?
    
    var selectedTicker: String?
    class func historyView()->SCSearchHistoryView{
        let nib = UINib(nibName: "SCSearchHistoryView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCSearchHistoryView
        v.frame = UIScreen.main.bounds
        return v
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func clickSearchHistoryMaskButton(_ sender: Any) {
        hideSearchHistoryView { [weak self] in
            self?.delegate?.didClickMaskButton(view: self)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdtifier)
    }
    private func loadSearchHistoryRecord(){
        companies = CoreDataManager.shared.getAllCompany()
        tableView.reloadData()
    }
}
extension SCSearchHistoryView{
    func showSearchHistoryView(completion:@escaping ()->()){
        loadSearchHistoryRecord()
        addPopHorizontalAnimation(fromValue: -UIScreen.screenWidth() / 2, toValue: UIScreen.screenWidth() / 2, springBounciness: 8, springSpeed: 8, delay: 0) { (_, _) in
            completion()
        }
    }
    func hideSearchHistoryView(completion:@escaping ()->()){
        addPopHorizontalAnimation(fromValue: UIScreen.screenWidth() / 2, toValue: -UIScreen.screenWidth() / 2, springBounciness: 8, springSpeed: 8, delay: 0) { (_, _) in
            completion()
        }
    }
}
extension SCSearchHistoryView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = companies?.count ?? 0
        tableView.hideSeparatorWhenEmpty(count: count)
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTicker = companies?[indexPath.row].ticker
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdtifier, for: indexPath)
        cell.textLabel?.text = companies?[indexPath.row].ticker
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            guard let ticker = companies?[indexPath.row].ticker else{
                return
            }
            companies?.remove(at: indexPath.row)
            CoreDataManager.shared.deleteWith(ticker: ticker)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
            if selectedTicker == ticker{
                selectedTicker = nil
            }
        }
    }
}
