//
//  SCCompanyAboutHeaderView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCompanyAboutHeaderView: UIView {
    var listViewModel: SCStockListViewModel?{
        didSet{
            setupUI()
        }
    }
    
    class func headerView(height: CGFloat)->SCCompanyAboutHeaderView{
        let nib = UINib(nibName: "SCCompanyAboutHeaderView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCCompanyAboutHeaderView
        v.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.screenWidth(), height: height))
        return v
    }
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ceoLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var sectorLabel: UILabel!
}
private extension SCCompanyAboutHeaderView{
    func setupUI(){
        companyNameLabel.text = listViewModel?.profileViewModel?.companyFullName
        sectorLabel.text = listViewModel?.profileViewModel?.profile.profile?.sector
        ceoLabel.text = listViewModel?.profileViewModel?.profile.profile?.ceo
        industryLabel.text = listViewModel?.profileViewModel?.profile.profile?.industry
        websiteLabel.text = listViewModel?.profileViewModel?.profile.profile?.website
        exchangeLabel.text = listViewModel?.profileViewModel?.profile.profile?.exchange
        descriptionLabel.text = listViewModel?.profileViewModel?.profile.profile?.description
        
        recommendationLabel.text = listViewModel?.ratingsViewModel?.ratings.rating?.recommendation
        recommendationLabel.textColor = listViewModel?.ratingsViewModel?.recommendationLabelColor
        scoreLabel.text = listViewModel?.ratingsViewModel?.ratings.rating?.rating
        
        for index in 0..<(listViewModel?.ratingsViewModel?.starCount ?? 0){
            if index >= stackView.subviews.count{
                break
            }
            (stackView.subviews[index] as! UIImageView).isHidden = false
        }
    }
}
