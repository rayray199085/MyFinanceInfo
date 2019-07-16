//
//  SCStockDisplayView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SCRRefreshControl

protocol SCStockDisplayViewDelegate: NSObjectProtocol {
    func didPullRefreshControl(view: SCStockDisplayView, completion:@escaping ()->())
    func didSelectedCompany(view: SCStockDisplayView, ticker: String)
}
private let infoReuseIdentifier = "stock_info_cell"
private let forexReuseIdentifier = "stock_forex_cell"
private let cryptocurrenciesReuseIdentifier = "stock_cryptocurrencies_cell"
private let sectorPerformanceReuseIdentifier = "stock_sector_performance_cell"
class SCStockDisplayView: UIView {
    weak var delegate: SCStockDisplayViewDelegate?
    var listViewModel: SCStockListViewModel?
    lazy var refreshControl = SCRRefreshControl(style: .simple)
    
    class func displayView()->SCStockDisplayView{
        let nib = UINib(nibName: "SCStockDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCStockDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    @IBOutlet weak var tableView: UITableView!
    
    @objc private func loadData(){
        if listViewModel?.previewIndex == -1{
            refreshControl.endRefreshing()
            return 
        }
        refreshControl.beginRefreshing()
        delegate?.didPullRefreshControl(view: self, completion: { [weak self] in
            self?.refreshControl.endRefreshing()
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SCStockInfoCell", bundle: nil), forCellReuseIdentifier: infoReuseIdentifier)
        tableView.register(UINib(nibName: "SCStockForexCell", bundle: nil), forCellReuseIdentifier: forexReuseIdentifier)
        tableView.register(UINib(nibName: "SCStockCryptocurrenciesCell", bundle: nil), forCellReuseIdentifier: cryptocurrenciesReuseIdentifier)
        tableView.register(UINib(nibName: "SCStockSectorPerformanceCell", bundle: nil), forCellReuseIdentifier: sectorPerformanceReuseIdentifier)
    }
    
}
extension SCStockDisplayView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var itemCount = 0
        switch listViewModel?.previewIndex {
        case 0, 1, 2:
            itemCount = listViewModel?.infoViewModels?.count ?? 0
        case 3:
            itemCount = listViewModel?.forexViewModels?.count ?? 0
        case 4:
            itemCount = listViewModel?.cryptocurrenciesViewModels?.count ?? 0
        case 5:
            itemCount = listViewModel?.sectorPerformanceViewModels?.count ?? 0
        default:
            break
        }
        tableView.hideSeparatorWhenEmpty(count: itemCount)
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch listViewModel?.previewIndex {
        case 0, 1, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: infoReuseIdentifier, for: indexPath) as! SCStockInfoCell
            cell.viewModel = listViewModel?.infoViewModels?[indexPath.row]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: forexReuseIdentifier, for: indexPath) as! SCStockForexCell
            cell.viewModel = listViewModel?.forexViewModels?[indexPath.row]
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: cryptocurrenciesReuseIdentifier, for: indexPath) as! SCStockCryptocurrenciesCell
            cell.viewModel = listViewModel?.cryptocurrenciesViewModels?[indexPath.row]
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: sectorPerformanceReuseIdentifier, for: indexPath) as! SCStockSectorPerformanceCell
            cell.viewModel = listViewModel?.sectorPerformanceViewModels?[indexPath.row]
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch listViewModel?.previewIndex {
        case 0, 1, 2:
            return listViewModel?.infoViewModels?[indexPath.row].rowHeight ?? 0
        case 3, 5:
            return 35
        case 4:
            return 50
        default:
            break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch listViewModel?.previewIndex {
        case 0, 1, 2:
            guard let ticker = listViewModel?.infoViewModels?[indexPath.row].stockItem.ticker else{
                return
            }
            delegate?.didSelectedCompany(view: self, ticker: ticker)
        default:
            break
        }
    }
}
