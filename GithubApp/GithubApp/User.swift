//
//  User.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 15/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var login: String?
    @objc dynamic var imgURL: String?
    @objc dynamic var timestamp: Date?
    
    override class func primaryKey() -> String? {
        return "login"
    }
    
    init(login: String, imgURL: String) {
        self.login = login
        self.imgURL = imgURL
        self.timestamp = Date()
    }
    
    required init() {
    }
}
