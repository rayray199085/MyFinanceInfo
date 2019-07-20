//
//  SCSearchCompanyList.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 20/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCSearchCompanyList: Decodable {
    let symbolsList: [SCSearchCompanyItem]?
}

struct SCSearchCompanyItem: Decodable {
    let symbol: String?
    let name: String?
}
