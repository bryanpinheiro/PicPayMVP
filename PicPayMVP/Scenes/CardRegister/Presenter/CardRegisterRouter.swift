//
//  CardRegisterRouter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 05/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

class CardRegisterRouter {
    
    private weak var viewController: CardRegisterViewController?
    
    //MARK: Properties
    private let payment = "payment"
    
    init(_ viewController: CardRegisterViewController) {
        self.viewController = viewController
    }
    
    //MARK: PresentPayment
    func presentPayment(user: User){
        viewController?.performSegue(withIdentifier: payment, sender: user)
    }
    
    //MARK: Navigation
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let vc = segue.destination as? PaymentViewController {
            vc.user = sender as? User
            
            //Save user on core data
        }
    }
    
}
