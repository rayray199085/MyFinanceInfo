//
//  SCNewsTopHeadlines.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

struct SCNewsTopHeadlines: Decodable{
    let totalResults: Int?
    let articles: [SCNewsArticle]?
}

struct SCNewsArticle: Decodable{
    let source: SCNewsArticleSource?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
struct SCNewsArticleSource: Decodable{
    let id: String?
    let name: String?
}
