//
//  SCCompanyHistoricalPriceViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
struct SCCompanyHistoricalPriceViewModel {
    var date: String?
    var open: Double?
    var high: Double?
    var low: Double?
    var close: Double?
    var volume: Double?
   
    init(item: SCCompanyHistoricalPriceItem) {
        date = item.date
        open = roundValueFrom(value: item.open)
        high = roundValueFrom(value: item.high)
        low = roundValueFrom(value: item.low)
        close = roundValueFrom(value: item.close)
        volume = roundValueFrom(value: item.volume)
    }
    func roundValueFrom(value: Double?)->Double{
        return value?.rounded(toPlaces: 2) ?? 0
    }
}
