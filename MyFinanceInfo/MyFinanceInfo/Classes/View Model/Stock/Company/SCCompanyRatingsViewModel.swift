//
//  SCCompanyRatingsViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyRatingsViewModel {
    let ratings: SCCompanyRatings
    var recommendationLabelColor: UIColor?
    var roaLabelColor: UIColor?
    var roeLabelColor: UIColor?
    var debtLabelColor: UIColor?
    var peLabelColor: UIColor?
    var pbLabelColor: UIColor?
    var starCount: Int?
    
    init(ratings: SCCompanyRatings) {
        self.ratings = ratings
        starCount = ratings.rating?.score
        recommendationLabelColor = getLabelColor(score: ratings.rating?.score)
        roaLabelColor = getLabelColor(score: ratings.ratingDetails?.roa?.score)
        roeLabelColor = getLabelColor(score: ratings.ratingDetails?.roe?.score)
       
        debtLabelColor = getLabelColor(score: ratings.ratingDetails?.de?.score)
        peLabelColor = getLabelColor(score: ratings.ratingDetails?.pe?.score)
        pbLabelColor = getLabelColor(score: ratings.ratingDetails?.pb?.score)
    }
    func getLabelColor(score: Int?)->UIColor{
        return (score ?? 0) >= 4 ? InfoCommon.increasingPriceColor : InfoCommon.decreasingPriceColor
    }
}
