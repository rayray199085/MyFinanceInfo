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
    var author: String?
    var source: String?
    var description: String?
    var content: String?
    var link: String?
    
    var rowHeight: CGFloat?
    var imageUrlString: String?
    var publishAt: String?
    var detailsRowHeight: CGFloat?
    
    init(article: SCNewsArticle) {
        title = article.title
        author = article.author
        source = article.source?.name
        description = article.description
        content = article.content
        link = article.url
        
        rowHeight = calculateRowHight(title: title)
        imageUrlString = article.urlToImage
        if let publishTime = article.publishedAt,
           let date = InfoCommon.dateFormatter.date(from: publishTime){
           publishAt = date.sinaDateStringDescription
        }
        detailsRowHeight = calculateDetailsCellRowHeight(article: article)
    }
    
    func calculateDetailsCellRowHeight(article: SCNewsArticle)->CGFloat{
        let outterMargin: CGFloat = 10
        let innerMargin: CGFloat = 3
        let linkButtonHeight: CGFloat = 18
        let labelHeight: CGFloat = 16
        let viewSize = CGSize(width: UIScreen.screenWidth() - 2 * outterMargin, height: CGFloat(MAXFLOAT))
        var height = outterMargin
        height += article.title?.heightWithConstrainedWidth(width: viewSize.width, font: UIFont.boldSystemFont(ofSize: 17)) ?? 0
        // author + source + publish at
        height += 3 * (innerMargin + labelHeight)
        // description
        height += innerMargin + (article.description?.heightWithConstrainedWidth(width: viewSize.width, font: UIFont.boldSystemFont(ofSize: 17)) ?? 0)
        // content
        height += innerMargin + (article.content?.heightWithConstrainedWidth(width: viewSize.width, font: UIFont.boldSystemFont(ofSize: 17)) ?? 0)
        height += innerMargin + linkButtonHeight
        height += outterMargin
        return height
    }
    
    
    func calculateRowHight(title: String?)->CGFloat{
        guard let title = title else{
            return 90
        }
        let margin: CGFloat = 3
        let timeLabelHeight: CGFloat = 17
        let imageWidth: CGFloat = 150
        var height = margin
        let viewSize = CGSize(width: UIScreen.screenWidth() - 3 * margin - imageWidth, height: CGFloat(MAXFLOAT))
        height += title.heightWithConstrainedWidth(width: viewSize.width, font: UIFont.boldSystemFont(ofSize: 15))
        height += margin + timeLabelHeight
        height += margin
        return height > 90 ? height : 90
    }
}
