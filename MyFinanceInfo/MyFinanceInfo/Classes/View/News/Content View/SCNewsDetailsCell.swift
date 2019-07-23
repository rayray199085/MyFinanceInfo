//
//  SCNewsDetailsCell.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 23/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCNewsDetailsCellDelegate: NSObjectProtocol {
    func didClickLinkButton(view: SCNewsDetailsCell)
}
class SCNewsDetailsCell: UITableViewCell {
    weak var delegate: SCNewsDetailsCellDelegate?
    var viewModel: SCNewsArticleViewModel?{
        didSet{
            detailsTitleLabel.text = viewModel?.title
            authorLabel.text = viewModel?.author
            sourceLabel.text = viewModel?.source
            publishAtLabel.text = viewModel?.publishAt
            descriptionLabel.text = viewModel?.description
            contentLabel.text = viewModel?.content
        }
    }
    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var publishAtLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!

    @IBAction func clickLinkButton(_ sender: Any) {
        delegate?.didClickLinkButton(view: self)
    }
}
