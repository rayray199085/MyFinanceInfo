//
//  SCCompanyHistoricalPrice.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyHistoricalPrice:Decodable {
    let historical: [SCCompanyHistoricalPriceItem]?
}
struct SCCompanyHistoricalPriceItem:Decodable {
    let date: String?
    let open: Double?
    let high: Double?
    let low: Double?
    let close: Double?
    let volume: Double?
}
