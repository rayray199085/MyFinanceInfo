//
//  SCIndexesTableViewCell.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCIndexesTableViewCell: UITableViewCell {
    var viewModel: SCIndexesViewModel?{
        didSet{
            indexNameLabel.text = viewModel?.indexName
            priceLabel.text = viewModel?.price
            changeLabel.text = viewModel?.changes
            changeLabel.textColor = viewModel?.changesLabelColor
            changePercentageLabel.text = viewModel?.changesPercentage
            changePercentageLabel.textColor = viewModel?.changesPercentageLabelColor
        }
    }
    
    @IBOutlet weak var indexNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var changePercentageLabel: UILabel!
}
