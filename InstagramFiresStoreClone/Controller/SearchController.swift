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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabelView()
    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Helpers
    
    func configureTabelView() {
//        view.backgroundColor = .systemBlue
        
        tableView.register(UserCell.self, forCellReuseIdentifier: userCellID)
        tableView.rowHeight = 64
    }
}

// MARK: - UITabelViewDataSource

extension SearchController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellID, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
}
