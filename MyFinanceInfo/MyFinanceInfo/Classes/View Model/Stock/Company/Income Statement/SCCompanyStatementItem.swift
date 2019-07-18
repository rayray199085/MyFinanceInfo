//
//  SCCompanyStatementItem.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyStatementItem {
    let name: String
    let values: [Double]
    init(name: String, values: [Double]) {
        self.name = name
        self.values = values
    }
}
