//
//  SCStockListItem.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCStockListItem: Decodable{
    let ticker: String?
    let companyName: String?
    let price: String?
    let changes: Double?
    let changesPercentage: String?
}
