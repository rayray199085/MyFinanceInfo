//
//  SCNewsHeadlineCell.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 22/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCNewsHeadlineCell: UITableViewCell {
    var viewModel: SCNewsArticleViewModel?{
        didSet{
            newsTitleLabel.text = viewModel?.title
            newsImageView.setImage(urlString: viewModel?.imageUrlString, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
}
