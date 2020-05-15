//
//  Database.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 15/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import Foundation
import RealmSwift

class Database {
    //MARK: Singleton
    static let sharedInstance = Database()
    
    let realmFile = try! Realm()
    
    func insert(user: User) {
        try! realmFile.write {
            realmFile.add(user)
        }
    }

    func insert(for users: [User]) {
        try! realmFile.write({
            realmFile.add(users, update: .modified)
        })
    }

    func fetchByTimestamp() -> Results<User> {
        let currentDate = Date()
        let cacheDate = Date().addingTimeInterval(TimeInterval(Constants.cacheTimeExpiring))
        let byTimestamp = NSPredicate(format: "timestamp >= %@ AND timestamp <= %@", cacheDate as CVarArg, currentDate as CVarArg)
        
        let users = realmFile.objects(User.self).filter(byTimestamp)
        return users
    }
    
    func fetch() -> Results<User> {
        let users = realmFile.objects(User.self)
        return users
    }
}
