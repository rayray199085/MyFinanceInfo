//
//  SCCompanyProfile.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyProfile: Decodable {
    let symbol: String?
    let profile: SCCompanyProfileContent?
}

struct SCCompanyProfileContent: Decodable {
    let price: Double?
    let beta: String?
    let volAvg: String?
    let mktCap: String?
    let lastDiv: String?
    let companyName: String?
    let exchange: String?
    let industry: String?
    let website: String?
    let description: String?
    let ceo: String?
    let sector: String?
}
