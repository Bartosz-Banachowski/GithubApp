//
//  UsersViewModel.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 13/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import Foundation

class UsersViewModel: NSObject {
    
    private var userService = DataService()
    var count: Int = 0
    var users: [Item] = [] {
        didSet {
            self.finishSetupView?()
        }
    }
    
    var finishSetupView: (() -> Void)?

    func getUserData(for user: String) {
        userService.requestUserData(user) { [weak self] (response, error) in
            if case .failure = error {
                print(error.debugDescription)
                return
            }
            
            guard let data = response else {
                return
            }
            self?.users.append(contentsOf: data.items)
            self?.count = data.totalCount
        }
    }
}
