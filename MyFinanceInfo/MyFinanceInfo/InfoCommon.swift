//
//  InfoCommon.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct InfoCommon{
    static let tinColor = UIColor(displayP3Red: 79.0 / 250, green: 159.0 / 250, blue: 79.0 / 250, alpha: 1.0)
    static let barColor = UIColor(displayP3Red: 192.0 / 250, green: 192.0 / 250, blue: 192.0 / 250, alpha: 1.0)
    static let tabbarNormalColor = UIColor(displayP3Red: 128.0 / 250, green: 128.0 / 250, blue: 128.0 / 250, alpha: 1.0)
    static let navHighlightedColor = UIColor(displayP3Red: 68.0 / 250, green: 68.0 / 250, blue: 68.0 / 250, alpha: 1.0)
    static let increasingPriceColor = UIColor(displayP3Red: 83.0 / 250, green: 164.0 / 250, blue: 81.0 / 250, alpha: 1.0)
    static let decreasingPriceColor = UIColor(displayP3Red: 189.0 / 250, green: 63.0 / 250, blue: 68.0 / 250, alpha: 1.0)
    
    static let baseUrl = "https://financialmodelingprep.com/api/v3"
    static let newsUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=c53eb778bee44e6f9e2b0349d1bf9e24"
}
