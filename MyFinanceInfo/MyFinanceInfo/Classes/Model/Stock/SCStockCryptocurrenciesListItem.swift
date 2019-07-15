//
//  SCStockCryptocurrenciesListItem.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 15/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
struct SCStockCryptocurrenciesListItem: Decodable {
    let ticker: String?
    let name: String?
    let price: Double?
    let changes: Double?
    let marketCapitalization: Int?
}
