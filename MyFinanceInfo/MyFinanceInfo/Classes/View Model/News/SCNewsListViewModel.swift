//
//  SCNewsListViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 18/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCNewsListViewModel{
    func loadTopHeadlines(completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getTopHeadlines { (data, isSuccess) in
            guard let data = data,
                  let topHeadlines = try? JSONDecoder().decode(SCNewsTopHeadlines.self, from: data) else{
                completion(false)
                return 
            }
            print(topHeadlines)
            completion(true)
        }
    }
}
