//
//  SCStockForexCell.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStockForexCell: UITableViewCell {
    var viewModel: SCStockForexViewModel?{
        didSet{
            pairLabel.text = viewModel?.item.ticker
            priceLabel.text = viewModel?.price
            changesLabel.text = viewModel?.changes
            changesPercentageLabel.text = viewModel?.changesPercentage
            
            changesLabel.textColor = viewModel?.changesColour
            changesPercentageLabel.textColor = viewModel?.changesPercentageColour
        }
    }
    @IBOutlet weak var pairLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changesLabel: UILabel!
    @IBOutlet weak var changesPercentageLabel: UILabel!
}
