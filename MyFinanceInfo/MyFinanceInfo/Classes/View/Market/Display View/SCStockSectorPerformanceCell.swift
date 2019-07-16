//
//  SCStockSectorPerformanceCell.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStockSectorPerformanceCell: UITableViewCell {
    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var changesPercentageLabel: UILabel!
    
    
    var viewModel: SCStockSectorViewModel?{
        didSet{
            sectorLabel.text = viewModel?.item.sector
            changesPercentageLabel.text = viewModel?.changesPercentage
            changesPercentageLabel.textColor = viewModel?.changesPercentageColor
        }
    }
}
