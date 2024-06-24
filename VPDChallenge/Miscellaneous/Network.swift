//
//  Network.swift
//  LawPavillionApp
//
//  Created by Mas'ud on 11/6/22.
//

import Foundation

class Network {
    
    static let shared = Network()
    
    func makeCall(page: Int?, isLoader: Bool, completion: @escaping (APIResult?, String?) -> Void) {
        
        var query = ""
        
        query = Constants.url + "a" + "&page=\(String(page ?? 1))&per_page=20"
        print(query)
        guard let url = URL(string: query) else {return}
        if isLoader{
            //Utility.showProgressHUD()
        }
        let session = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            //Utility.hideProgressHUD()
            if let err = error {
                
                completion(nil, err.localizedDescription)
                print(err.localizedDescription)
            }else {
                
                if let responseData = data {
                    
                    let jsonRes = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any]
                    //print(jsonRes)
                    let res = try? JSONDecoder().decode(APIResult.self, from: responseData)
                    
                    if let res = res {
                        
                        
                        //let repoArray = totalItems.map({APIRepo(id: $0.id, name: $).name, description: $0.descrip, url: <#T##String#>, owner: <#T##Owner#>)})
                        completion(res, nil)
                        
                    }else {
                        print("did not decode")
                        completion(nil, "There was a problem getting data, please try again")
                    }
                   
                    
                }
                
                //print("did not decode")
                
            }
        }).resume()
    }
    
}

struct Response {
    
    var successful : Bool
    var message: String?
    var object : Any?
}
