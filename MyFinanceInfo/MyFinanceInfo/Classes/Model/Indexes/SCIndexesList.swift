//
//  SCIndexesList.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCIndexesList: Decodable {
    let majorIndexesList: [SCIndexesListItem]?
}
struct SCIndexesListItem: Decodable {
    let ticker: String?
    let indexName: String?
    let price: Double?
    let changes: Double?
}
