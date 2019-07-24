//
//  SCMoreTableViewCell.swift
//  CardsHelper
//
//  Created by Stephen Cao on 25/6/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit

class SCMoreTableViewCell: UITableViewCell {
    var content: [String: String]?{
        didSet{
            guard let imageName = content?["iconName"],
                  var titleName = content?["title"],
                  let contentText = content?["content"] else{
                    return 
            }
            iconImageView.image = UIImage(named: imageName)
            if titleName == "Current country code: "{
                 titleName += (UserDefaults.standard.object(forKey: InfoCommon.regionKey) as? String) ?? "us"
            }
            titleNameLabel.text = titleName
            titleContentLabel.text = contentText
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var titleContentLabel: UILabel!
}
