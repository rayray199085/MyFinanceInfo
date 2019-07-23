//
//  SCNewsListViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCNewsListViewModel{
    var currentSegmentName: String?
    var viewModels: [SCNewsArticleViewModel]?
    var totalArticles: Int = 0
    
    func loadTopHeadlines(pageIndex: Int = 1, segmentName: String, completion:@escaping (_ isSuccess: Bool)->()){
        currentSegmentName = segmentName
        SCNetworkManager.shared.getTopHeadlines(pageIndex: pageIndex, segmentName: segmentName) { (data, isSuccess) in
            guard let data = data,
            let topHeadlines = try? JSONDecoder().decode(SCNewsTopHeadlines.self, from: data) else{
                completion(false)
                return
            }
            self.totalArticles = topHeadlines.totalResults ?? 0
            var viewModels = [SCNewsArticleViewModel]()
            for article in topHeadlines.articles ?? []{
                viewModels.append(SCNewsArticleViewModel(article: article))
            }
            if self.viewModels == nil{
                self.viewModels = viewModels
            }else{
                self.viewModels! += viewModels
            }
            completion(true)
        }
    }
}
