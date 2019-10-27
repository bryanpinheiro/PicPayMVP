//
//  UsersPresenter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UsersPresenter {
    
    //MARK: PROPERTIES
    private(set) weak var view: UserPresenterView!
    private var router: UsersPresenterRouter
    
    //MARK: VARIABLES
    var users: [User] = []
    var filteredUsers: [User] = []
    var isFiltered: Bool = false
    var images: [Data] = []
    var cardExists: Bool = false
    
    //MARK: CONSTRUCTOR
    init(view: UserPresenterView, router: UsersPresenterRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: ViewDidLoad
    func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            NetworkManager.shared.getContatos(completion: { (response, error) in
                if(error == nil){
                    guard let r = response else { return }
                    self?.users = r
                    self?.view.reloadData()
                }
            })
        }
    }
    
    //MARK: Network
    private func getUsers(completed: @escaping([User]?, String?) -> Void) {
        NetworkManager.shared.getContatos { (response, error) in
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
            images.removeAll()
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
    @available(iOS 13.0, *)
    func onDidSelectRowAt(for row: Int, isActive: Bool){
        if(load() == nil) {
            router.presentCardRegister()
        }
        else{
            let image = images[row]
            if isActive {
                AppData.User = filteredUsers[row]
                AppData.Image = UIImage(data: image, scale: 1.0)
                router.presentPayment()
            } else {
                AppData.User = users[row]
                AppData.Image = UIImage(data: image, scale: 1.0)
                router.presentPayment()
            }
        }
    }
    
    func load() -> Card? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        var cardArray: [Card]?
        
        do{
            cardArray = try context.fetch(request)
        }
        catch
        {
            print("Error fetching data from context: \(error)")
        }
        
        if(cardArray!.isEmpty){
            return nil
        }
        else {
            return cardArray![0]
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
            guard let data = image.jpegData(compressionQuality: 1) else { return }
            self.images.append(data)
        }
    }
    
    //MARK: GET CARD FROM CORE DATA
    func load(){
        
    }
    
}

//MARK: CONVERT IMAGE TO DATA
extension UIImage {
    var jpeg: Data?  {
        return jpegData(compressionQuality: 1)
    }
    var png: Data? {
        return pngData()
    }
}
