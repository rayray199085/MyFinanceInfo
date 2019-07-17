//
//  SCCompanyProfileViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCCompanyProfileViewModel {
    let profile: SCCompanyProfile
    var viewHeight: CGFloat?
    var price: String?
    var beta: String?
    var volAvg: String?
    var mktCap: String?
    var companyFullName: String?
    
    init(profile: SCCompanyProfile) {
        self.profile = profile

        companyFullName = "\(profile.profile?.companyName ?? "") (\(profile.symbol ?? ""))"
        viewHeight = calculateViewHeight()
        
        let profilePrice = profile.profile?.price ?? 0
        price = String(format: "%.2f$", profilePrice.rounded(toPlaces: 2))
        
        let profileBeta = Double(profile.profile?.beta ?? "0") ?? 0
        beta = String(format: "%.2f", profileBeta.rounded(toPlaces: 2))
        
        volAvg = getFormatString(stringValue: profile.profile?.volAvg)
        
        mktCap = getFormatString(stringValue: profile.profile?.mktCap)
        
    }
    
    func getFormatString(stringValue: String?)->String{
        let value = Double(stringValue ?? "0") ?? 0
        return value.formatNumber()
    }
    
    func calculateViewHeight()->CGFloat{
        let margin: CGFloat = 3
        let titleHeight: CGFloat = 20.5
        let labelHeight: CGFloat = 18
        let viewSize = CGSize(width: UIScreen.screenWidth() - 2 * margin, height: CGFloat(MAXFLOAT))
        // company name
        var height = margin
        height += companyFullName?.getTextHeight(size: viewSize, font: UIFont.boldSystemFont(ofSize: 17)) ?? 0
        // sector
        height += margin + titleHeight
        height += 8 * (margin + labelHeight)
        // description
        height += margin + (profile.profile?.description?.getTextHeight(size: viewSize, font: UIFont.systemFont(ofSize: 15)) ?? 0)
        height += margin * 4
        return height
    }
}
