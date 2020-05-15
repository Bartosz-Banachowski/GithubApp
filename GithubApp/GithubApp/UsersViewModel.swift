//
//  UsersViewModel.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 13/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import Foundation
import RealmSwift

class UsersViewModel: NSObject {
    private var userService = DataService()
    private var database = Database.sharedInstance
    
    var users: [User] = [] {
        didSet {
            self.finishSetupView?()
        }
    }
    
    var finishSetupView: (() -> Void)?

    func fetchData() {
        let results = database.fetch()
        users = Array(results)
    }

    func getUserData(for user: String) {
        //check your local db
        let isExpired = didUserExpired(for: user)

        if isExpired {
            deleteExpiredUsers()
            userService.requestUserData(user) { [weak self] (response, error) in
                if case .responseFailure = error {
                    print(error.debugDescription)
                    return
                }
                if case .connectionFailure = error {
                    print("Connection interupted")
                    return
                }
                guard let data = response else {
                    return
                }

                for item in data.items {
                    let user = User(login: item.login, imgURL: item.avatarURL)
                    if !(self?.users.contains(user) ?? false) {
                        self?.users.append(user)
                    }
                }
                
                self?.database.insert(for: self?.users ?? [])
            } 
        }
    }
    
    private func didUserExpired(for user: String) -> Bool {
         return !database.fetchByTimestamp().contains { (dbUser) -> Bool in
            dbUser.login?.lowercased() == user.lowercased()
        }
    }
    
    private func deleteExpiredUsers() {
        // Depends, right now entities are updated once on 15 min
        // In case where req for specific user called long time ago, could delete enityty
    }
}
