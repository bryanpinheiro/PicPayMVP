//
//  UsersPresenterRouter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 31/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

struct InfoUser {
    var userData: User
    var imageData: Data
}

class UsersPresenterRouter {
 
    private weak var viewController: UserViewController?
    
    //MARK: properties
    private let payment = "payment"
    private let cardRegister = "cardregister"
    
    init(_ viewController: UserViewController){
        self.viewController = viewController
    }
    
    //MARK: PresentPayment
    func presentPayment(user: User, data: Data){
        let info:InfoUser = InfoUser.init(userData: user, imageData: data)
        viewController?.performSegue(withIdentifier: payment, sender: info)
    }
    
    //MARK: PresentCardRegister
    func presentCardRegister(){
        viewController?.performSegue(withIdentifier: cardRegister, sender: self)
    }
    
    //MARK: Navigation
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == payment {
            let vc = segue.destination as! PaymentViewController
            let info = sender as! InfoUser
            let image = UIImage(data: info.imageData, scale: 1.0)
            vc.user = info.userData
            vc.image = image
        }
    }
    
}
