//
//  SearchController.swift
//  InstagramFiresStoreClone
//
//  Created by Mabast on 11/6/22.
//

import UIKit

class SearchController: UITableViewController {
    
    // MARK: - Properties
    private let userCellID = "userCellID"
    private var users = [User]()
    private var filteredUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isSearching: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabelView()
        fetchUser()
        configureSearchController()
    }
    
    // MARK: - Actions
    
    
    // MARK: - Network Call
    
    func fetchUser() {
        UserService.fetchAllUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Helpers
    
    func configureTabelView() {
        tableView.register(UserCell.self, forCellReuseIdentifier: userCellID)
        tableView.rowHeight = 64
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

// MARK: - UITabelViewDataSource

extension SearchController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellID, for: indexPath) as! UserCell
        let user = isSearching ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredUsers.count : users.count
    }
    
}

// MARK: - UITabelViewDelegate

extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearching ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filteredUsers = users.filter({ $0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText) })
        self.tableView.reloadData()
    }
}
