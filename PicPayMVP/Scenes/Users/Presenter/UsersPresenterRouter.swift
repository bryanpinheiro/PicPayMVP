//
//  UsersPresenterRouter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 31/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UsersPresenterRouter {
 
    private weak var viewController: UserViewController?
    
    //MARK: properties
    private let payment = "payment"
    private let cardRegister = "cardRegister"
    
    init(_ viewController: UserViewController){
        self.viewController = viewController
    }
    
    //MARK: PresentPayment
    func presentPayment(user: User){
        viewController?.performSegue(withIdentifier: payment, sender: user)
    }
    
    //MARK: PresentCardRegister
    func presentCardRegister(user: User){
        viewController?.performSegue(withIdentifier: cardRegister, sender: user)
    }
    
    //MARK: Navigation
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == payment{
            if let vc = segue.destination as? PaymentViewController {
                vc.user = sender as? User
                //Save user on core data
            }
        }
        else {
            if let vc = segue.destination as? CardRegisterViewController{
                //Save user on core data
            }
        }

    }
    
    //MARK: MODEL Manupulation Methods
    
    func saveUser(_ user: User?){
        guard let u = user else { return }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //setup user object
        let entity = NSEntityDescription.entity(forEntityName: "UserModel", in: context)!
        let user = NSManagedObject(entity: entity, insertInto: context)
        user.setValue(Int32(u.id), forKey: "id")
        user.setValue(u.name, forKey: "name")
        user.setValue(u.username, forKey: "username")
        user.setValue(u.img, forKey: "img")
        
        do{
            try context.save()
        }
        catch let error as NSError{
            print("Could not save.")
        }
        
    }
    
    func loadUser(){
        
    }

}
