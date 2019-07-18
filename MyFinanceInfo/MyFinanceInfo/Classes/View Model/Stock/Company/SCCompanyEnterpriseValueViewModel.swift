//
//  SCCompanyEnterpriseValueViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyEnterpriseValueViewModel {
    var year: String?
    var sharesValue: String?
    
    init(item: SCCompanyEnterpriseValueItem) {
        let date = item.date ?? ""
        year = "Shares(\((date as NSString).substring(with: NSRange(location: 0, length: 4))))"
        
        let shares = Double(item.numberOfShares ?? "0") ?? 0
        sharesValue = shares.formatNumber()
    }
}
