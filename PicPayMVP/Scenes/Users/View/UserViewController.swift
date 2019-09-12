//
//  UserViewController.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    var activityIndicatorView: UIActivityIndicatorView!
    var users: [User]?
    
    //MARK: Presenter
    lazy var presenter: UsersPresenter = {
        let p = UsersPresenter(view: self, router: UsersPresenterRouter(self))
        return p
    }()
    
    lazy var searchController = UISearchController(searchResultsController: nil)
 
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearch()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.accessibilityIdentifier = "UsersTableview"
        searchController.accessibilityTraits = UIAccessibilityTraits.searchField
        presenter.viewDidLoad()
    }
    
    //MARK: Functions
    private func configureSearch(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.tintColor = .white
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        presenter.prepare(for: segue, sender: sender)
    }

}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return presenter.filteredUsers.count
        } else {
            return presenter.users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mCell, for: indexPath) as! UserCell
        presenter.configureCell(cell, for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onDidSelectRowAt(for: indexPath.row, isActive: false)
    }
    
}

extension UserViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            presenter.filtered(text)
        }
    }
}

extension UserViewController: UserPresenterView {
    
    func startLoading() {
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(.black)
    }
    
    func stoploading() {
        SVProgressHUD.dismiss()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
