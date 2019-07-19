//
//  SCIndexesListViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 19/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCIndexesListViewModel{
    var viewModels: [SCIndexesViewModel]?
    
    func loadMajorIndexes(completion:@escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getMajorIndexes { (data, isSuccess) in
            guard let data = data,
                  let indexesList = try? JSONDecoder().decode(SCIndexesList.self, from: data) else{
                completion(false)
                return
            }
            var viewModels = [SCIndexesViewModel]()
            for item in indexesList.majorIndexesList ?? []{
                viewModels.append(SCIndexesViewModel(item: item))
            }
            self.viewModels = viewModels
            completion(true)
        }
    }
}
