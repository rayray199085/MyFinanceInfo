//
//  SCStockSectorPerformanceItem.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
struct SCStockSectorPerformanceItem: Decodable {
    let sector: String?
    let changesPercentage: String?
}
