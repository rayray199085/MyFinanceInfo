//
//  SCStockInfoCell.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStockInfoCell: UITableViewCell {
    var viewModel: SCStockInfoViewModel?{
        didSet{
            tickerLabel.text = viewModel?.stockItem.ticker
            nameLabel.text = viewModel?.stockItem.companyName
            priceLabel.text = viewModel?.price
            changeLabel.text = viewModel?.changes
            changeLabel.textColor = viewModel?.changesColour
            changePercentageLabel.text = viewModel?.changesPercentage
            changePercentageLabel.textColor = viewModel?.changesPercentageColour
        }
    }
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var changePercentageLabel: UILabel!
    
}
