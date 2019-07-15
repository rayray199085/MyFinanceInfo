//
//  SCStockForexListItem.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCStockForexListItem: Decodable {
    let ticker: String?
    let bid: String?
    let ask: String?
    let open: String?
    let low: String?
    let high: String?
    let changes: Double?
    let date: String?
}
