//
//  SCCompanyAboutController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 17/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCompanyAboutController: UITableViewController {

    var listViewModel: SCStockListViewModel?{
        didSet{
            let headerView = SCCompanyAboutHeaderView.headerView(height: listViewModel?.profileViewModel?.viewHeight ?? 0)
            headerView.listViewModel = listViewModel
            tableView.tableHeaderView = headerView
            setupTableViewContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
    }
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var betaLabel: UILabel!
    @IBOutlet weak var volumeAvrgLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var sharesTitleLabel: UILabel!
    
    @IBOutlet weak var lastDivLabel: UILabel!
    @IBOutlet weak var dividendYieldLabel: UILabel!
    
    @IBOutlet weak var roeValueLabel: UILabel!
    @IBOutlet weak var roeRecommendationLabel: UILabel!
    
    @IBOutlet weak var roaValueLabel: UILabel!
    @IBOutlet weak var roaRecommendationLabel: UILabel!
    
    @IBOutlet weak var operatingMarginValueLabel: UILabel!
    @IBOutlet weak var operatingMarginRecommendationLabel: UILabel!
    
    @IBOutlet weak var debtEquityValueLabel: UILabel!
    @IBOutlet weak var debtEquityRecommendationLabel: UILabel!
    
    @IBOutlet weak var peValueLabel: UILabel!
    @IBOutlet weak var peRecommendationLabel: UILabel!
    
    @IBOutlet weak var pbValueLabel: UILabel!
    @IBOutlet weak var pbRecommendationLabel: UILabel!
}
private extension SCCompanyAboutController{
    func setupTableViewContent(){
        symbolLabel.text = listViewModel?.profileViewModel?.profile.symbol
        priceLabel.text = listViewModel?.profileViewModel?.price
        betaLabel.text = listViewModel?.profileViewModel?.beta
        lastDivLabel.text = listViewModel?.profileViewModel?.profile.profile?.lastDiv
        volumeAvrgLabel.text = listViewModel?.profileViewModel?.volAvg
        marketCapLabel.text = listViewModel?.profileViewModel?.mktCap
        
        sharesTitleLabel.text = listViewModel?.enterpriseValueViewModel?.year
        sharesLabel.text = listViewModel?.enterpriseValueViewModel?.sharesValue
        dividendYieldLabel.text = listViewModel?.keyMetricsViewModel?.dividendYield
        
        roaValueLabel.text = listViewModel?.financialRatiosViewModel?.roa
        roeValueLabel.text = listViewModel?.financialRatiosViewModel?.roe
        operatingMarginValueLabel.text = listViewModel?.financialRatiosViewModel?.operatingMargin
        debtEquityValueLabel.text = listViewModel?.financialRatiosViewModel?.debt
        peValueLabel.text = listViewModel?.financialRatiosViewModel?.pe
        pbValueLabel.text = listViewModel?.financialRatiosViewModel?.pb
        
        roaRecommendationLabel.text = listViewModel?.ratingsViewModel?.ratings.ratingDetails?.roa?.recommendation
        roeRecommendationLabel.text = listViewModel?.ratingsViewModel?.ratings.ratingDetails?.roe?.recommendation
        
        debtEquityRecommendationLabel.text = listViewModel?.ratingsViewModel?.ratings.ratingDetails?.de?.recommendation
        peRecommendationLabel.text = listViewModel?.ratingsViewModel?.ratings.ratingDetails?.pe?.recommendation
        pbRecommendationLabel.text = listViewModel?.ratingsViewModel?.ratings.ratingDetails?.pb?.recommendation
        
        roaRecommendationLabel.textColor = listViewModel?.ratingsViewModel?.roaLabelColor
        roeRecommendationLabel.textColor = listViewModel?.ratingsViewModel?.roeLabelColor
        
        debtEquityRecommendationLabel.textColor = listViewModel?.ratingsViewModel?.debtLabelColor
        peRecommendationLabel.textColor = listViewModel?.ratingsViewModel?.peLabelColor
        pbRecommendationLabel.textColor = listViewModel?.ratingsViewModel?.pbLabelColor
    }
}
