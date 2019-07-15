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
            print(viewModel)
        }
    }
}
