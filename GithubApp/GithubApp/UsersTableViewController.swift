//
//  UsersTableViewController.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 11/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    @IBOutlet var userTableView: UITableView!
    private let usersViewModel = UsersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        usersViewModel.getUsersData()
        
        usersViewModel.finishSetupView = {
            self.userTableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userItem", for: indexPath)
        cell.textLabel?.text = usersViewModel.users[indexPath.row].login

        return cell
    }
}
