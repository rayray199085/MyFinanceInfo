//
//  SCCompanyKeyMetricsViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyKeyMetricsViewModel {
    let keyMetricsItem : SCCompanyKeyMetricsItem
    let dividendYield: String?
    
    init(keyMetricsItem: SCCompanyKeyMetricsItem) {
        self.keyMetricsItem = keyMetricsItem
        let yield = Double(keyMetricsItem.dividendYield ?? "0") ?? 0
        dividendYield = String(format: "%.2f%%", (yield * 100).rounded(toPlaces: 2))
    }
}
