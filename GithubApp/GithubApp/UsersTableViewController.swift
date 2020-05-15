//
//  UsersTableViewController.swift
//  GithubApp
//
//  Created by Bartosz Banachowski on 11/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var userTableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let usersViewModel = UsersViewModel()
    
    private var previousRun = Date()
    private let minInterval = 0.05

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.tableFooterView = UIView()
        setupSearchBar()
        setupBackgroundView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        usersViewModel.users.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }
        
        if Date().timeIntervalSince(previousRun) > minInterval {
            previousRun = Date()
            usersViewModel.getUserData(for: textToSearch)
            usersViewModel.finishSetupView = {
                self.userTableView.reloadData()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        usersViewModel.users.removeAll()
    }

    // MARK: - view setup func
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search user"
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        userTableView.tableHeaderView = searchController.searchBar
    }

    private func setupBackgroundView() {
        let backgroundViewLabel = UILabel(frame: .zero)
        backgroundViewLabel.text = "Nothing new, search some users! "
        backgroundViewLabel.textColor = .darkGray
        backgroundViewLabel.numberOfLines = 0
        backgroundViewLabel.font.withSize(20)
        backgroundViewLabel.textAlignment = NSTextAlignment.center
        userTableView.backgroundView = backgroundViewLabel
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userItem", for: indexPath)
        cell.textLabel?.text = usersViewModel.users[indexPath.row].login
        return cell
    }
}
