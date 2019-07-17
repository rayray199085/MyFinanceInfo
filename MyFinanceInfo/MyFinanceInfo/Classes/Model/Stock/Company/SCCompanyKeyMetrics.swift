//
//  SCCompanyKeyMetrics.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyKeyMetrics: Decodable {
    let metrics: [SCCompanyKeyMetricsItem]?
}
struct SCCompanyKeyMetricsItem: Decodable {
    let dividendYield: String?

    private enum CodingKeys: String, CodingKey {
        case dividendYield = "Dividend Yield"
    }
}
