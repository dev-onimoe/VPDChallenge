//
//  ViewModel.swift
//  VPDChallenge
//
//  Created by Masud Onikeku on 21/06/2024.
//

import Foundation

class ViewModel {
    
    var responseObserver : Observable<Response?> = Observable(nil)
    var page = 1
    var repos : [APIRepos] = []
     
    func getData(page: Int) {
        
        Network.shared.makeCall(page: page, isLoader: true, completion: {[weak self] result, errorString in
            
            if let res = result {
                
                let total_cost = res.total_count
                UserDefaults.standard.set(Int(total_cost/20), forKey: "total_pages")
                
                let repos = res.items
                let totalItems = repos.sorted(by: { ($0.owner.login.lowercased() < ($1.owner.login.lowercased()))})
                if self?.page == 1 {
                    CoreDataManager.shared.createData(data: totalItems, page: String(page))
                }
                
                self?.responseObserver.value = Response(successful: true, object: totalItems)
                UserDefaults.standard.setValue(page, forKey: "page")
            }else {
                self?.responseObserver.value = Response(successful: false, message: errorString ?? "", object: nil)
            }
        })
    }
    
    func updateCoreData(repos: [APIRepo], page: String) {
        
        CoreDataManager.shared.updateData(page: page, repos: repos)
    }
}
