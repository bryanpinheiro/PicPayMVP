//
//  UsersPresenterRouter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 31/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

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
        if segue.identifier == "segu"{
            if let vc = segue.destination as? PaymentViewController {
                vc.user = sender as? User
                
                //Save user on core data
            }
        }
        else {
            
        }

    }

}
