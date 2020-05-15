//
//  DataService.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 12/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import Foundation
import Alamofire

struct DataService {
    private let baseURL = "https://api.github.com/search/users?q="
    
    func requestUserData(_ user: String, completion: @escaping (Response?, NetworkError?) -> ()) {
        let URL = "\(baseURL)\(user)"

        AF.request(URL).responseJSON { (response) in
            if response.error != nil {
                completion(nil, .failure)
                return
            }
            
            if let jsonData = response.data {
                do {
                    let usersData = try JSONDecoder().decode(Response.self, from: jsonData)
                    completion(usersData, .success)
                } catch {
                    print("Unexpected problem during fetching users data: \(error)")
                }
            }
        }
    }
}
