//
//  SCStockSectorPerformanceCell.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStockSectorPerformanceCell: UITableViewCell {
    var item: SCStockSectorPerformanceItem?{
        didSet{
            print(item)
        }
    }
}
