//
//  UsersPresenter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

class UsersPresenter {
    
    private(set) weak var view: UserPresenterView!
    private var router: UsersPresenterRouter
    
    var users: [User] = []
    var filteredUsers: [User] = []
    var isFiltered: Bool = false
    
    init(view: UserPresenterView, router: UsersPresenterRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: ViewDidLoad
    func viewDidLoad() {
        view.startLoading()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self!.view.stoploading()
            self?.getUsers(completed: { (response, error) in
                if(error == nil){
                    guard let r = response else { return }
                    self?.users = r.results
                    self!.view.reloadData()
                }
            })
        }
    }
    
    //MARK: Network
    private func getUsers(completed: @escaping(Response?, String?) -> Void) {
        NetworkManager.shared.getPopular() { (response, error) in
            if(error == nil){
                completed(response, nil)

            } else {
                completed(nil, error)
            }
        }
    }
    
    //MARK: Filtered
    func filtered(_ searchText: String, scope: String = "All"){
        if searchText != "" {
            isFiltered = true
            filteredUsers = users.filter { item in
                return (item.name.lowercased().contains(searchText.lowercased()))
            }
        } else {
            isFiltered = false
            filteredUsers = users
        }
        view.reloadData()
    }
    
    //MARK: onDidSelect
    func onDidSelectRowAt(for row: Int, isActive: Bool){
        if isActive {
            router.presentPayment(user: filteredUsers[row])
        } else {
            router.presentPayment(user: users[row])
        }
    }
    
    //MARK: Cell
    func configureCell(_ cell: UserCellPresenterView, for row: Int){
        var image: String?
        
        var user: User?
        user = isFiltered ? filteredUsers[row] : users[row]

        guard let u = user else { return }
        cell.displayLabels(username: u.username, name: u.name)
        image = u.img
        
        guard let i = image else { return }
        NetworkImage.shared.downloadImageFrom(endpoint: i) { (image) in
            cell.displayImage(image: image)
        }
        
    }
    
    //MARK: Navigation
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        router.prepare(for: segue, sender: sender)
    }
    
}
