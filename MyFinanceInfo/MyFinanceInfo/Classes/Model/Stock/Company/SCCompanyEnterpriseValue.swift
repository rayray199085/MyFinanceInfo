//
//  SCCompanyEnterpriseValue.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyEnterpriseValue: Decodable {
    let enterpriseValues: [SCCompanyEnterpriseValueItem]?
}
struct SCCompanyEnterpriseValueItem: Decodable {
    let date: String?
    let numberOfShares: String?
    
    private enum CodingKeys: String, CodingKey {
        case date
        case numberOfShares = "Number of Shares"
    }
}
