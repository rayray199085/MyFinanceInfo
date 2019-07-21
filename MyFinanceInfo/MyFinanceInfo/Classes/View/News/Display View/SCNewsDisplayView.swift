//
//  SCNewsDisplayView.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCNewsDisplayView: UIView {
    
    
    class func displayView()->SCNewsDisplayView{
        let nib = UINib(nibName: "SCNewsDisplayView", bundle: nil)
        let v = nib.instantiate(withOwner: self, options: nil)[0] as! SCNewsDisplayView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
   
}
private extension SCNewsDisplayView{
    func setupUI(){
    }
}

