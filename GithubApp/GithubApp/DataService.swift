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
    private let baseURL = "https://api.github.com/users?"
    
    func requestUsersData(completion: @escaping (data?, Error?) -> ()) {
        let URL = "\(baseURL)"

        AF.request(URL).responseJSON { (response) in
            if let error = response.error {
                completion(nil, error)
                return
            }
            
            if let jsonData = response.data {
                do {
                    print(jsonData)
                    let usersData = try JSONDecoder().decode(data.self, from: jsonData)
                    print(usersData)
                    completion(usersData, nil)
                } catch {
                    print("Unexpected problem during fetching users data: \(error)")
                }
            }
        }
    }
}
