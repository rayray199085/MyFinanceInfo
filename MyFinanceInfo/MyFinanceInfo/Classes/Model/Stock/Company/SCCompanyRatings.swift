//
//  SCCompanyRatings.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyRatings: Decodable {
    let rating: SCCompanyRatingsContent?
    let ratingDetails: SCCompanyRatingsDetails?
}
struct SCCompanyRatingsContent: Decodable {
    let score: Int?
    let recommendation: String?
    let rating: String?
}

struct SCCompanyRatingsDetails: Decodable {
    let roe : SCCompanyRatingsDetailsContent?
    let roa : SCCompanyRatingsDetailsContent?
    let de : SCCompanyRatingsDetailsContent?
    let pe : SCCompanyRatingsDetailsContent?
    let pb : SCCompanyRatingsDetailsContent?
    
    private enum CodingKeys: String, CodingKey {
        case roe = "ROE"
        case roa = "ROA"
        case de = "D/E"
        case pe = "P/E"
        case pb = "P/B"
    }
}
struct SCCompanyRatingsDetailsContent: Decodable {
    let score: Int?
    let recommendation: String?
}
