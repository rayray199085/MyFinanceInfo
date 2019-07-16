//
//  SCStockCryptocurrenciesCell.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStockCryptocurrenciesCell: UITableViewCell {
    var viewModel: SCStockCryptocurrenciesViewModel?{
        didSet{
            symbolLabel.text = viewModel?.item.ticker
            nameLabel.text = viewModel?.item.name
            priceLabel.text = viewModel?.price
            changesLabel.text = viewModel?.changes
            changesPercentageLabel.text = viewModel?.changesPercentage
            
            changesLabel.textColor = viewModel?.changesColour
            changesPercentageLabel.textColor = viewModel?.changesColour
        }
    }
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changesLabel: UILabel!
    @IBOutlet weak var changesPercentageLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
}
