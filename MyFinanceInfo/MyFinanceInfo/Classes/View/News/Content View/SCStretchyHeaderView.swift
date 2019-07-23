//
//  SCStretchyHeaderView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 23/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView

class SCStretchyHeaderView: GSKStretchyHeaderView {
    @IBOutlet weak var newsImageView: UIImageView!
    
    class func headerView(frame: CGRect)->GSKStretchyHeaderView{
        let nib = UINib(nibName: "SCStretchyHeaderView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCStretchyHeaderView
        v.frame = frame
        return v
    }
}
