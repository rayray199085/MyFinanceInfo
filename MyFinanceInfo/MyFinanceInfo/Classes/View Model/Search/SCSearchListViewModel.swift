//
//  SCSearchListViewModel.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 20/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

class SCSearchListViewModel: SCBaseListViewModel{
    var searchViewModels: [SCSearchViewModel]?
    var nameList: [String]?
    
    func loadCompanyList(completion: @escaping (_ isSuccess: Bool)->()){
        SCNetworkManager.shared.getCompanyList { (data, isSuccess) in
            guard let data = data,
                  let companyList = try? JSONDecoder().decode(SCSearchCompanyList.self, from: data) else{
                completion(false)
                return
            }
            var viewModels = [SCSearchViewModel]()
            var nameList = [String]()
            var tempList = companyList.symbolsList ?? []
            tempList.sort(by: { ($0.name ?? "") < ($1.name ?? "") })
            for item in tempList{
                let viewModel = SCSearchViewModel(item: item)
                viewModels.append(viewModel)
                nameList.append(viewModel.displayText ?? "")
            }
            self.searchViewModels = viewModels
            self.nameList = nameList
            completion(true)
        }
    }
}
