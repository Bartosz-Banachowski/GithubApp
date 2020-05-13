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
    var users: data = [] {
        didSet {
            self.finishSetupView?()
        }
    }
    
    var finishSetupView: (() -> Void)?

    func getUsersData() {
        userService.requestUsersData { (response, error) in
            if let err = error {
                print(err)
                return
            }
            self.users = response!
        }
    }
}
