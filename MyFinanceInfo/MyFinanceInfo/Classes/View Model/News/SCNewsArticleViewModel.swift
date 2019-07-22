//
//  SCNewsArticleViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 22/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCNewsArticleViewModel {
    var title: String?
    var rowHeight: CGFloat?
    var imageUrlString: String?
    
    init(article: SCNewsArticle) {
        title = article.title
        rowHeight = calculateRowHight(title: title)
        imageUrlString = article.urlToImage
    }
    func calculateRowHight(title: String?)->CGFloat{
        guard let title = title else{
            return 94
        }
        let margin: CGFloat = 3
        let imageWidth: CGFloat = 150
        var height = margin
        let viewSize = CGSize(width: UIScreen.screenWidth() - 3 * margin - imageWidth, height: CGFloat(MAXFLOAT))
        height += title.getTextHeight(size: viewSize, font: UIFont.boldSystemFont(ofSize: 15))
        height += margin * 4
        return height > 94 ? height : 94
    }
}
