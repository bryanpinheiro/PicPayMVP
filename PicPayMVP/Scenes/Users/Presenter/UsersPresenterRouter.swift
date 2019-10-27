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
    @available(iOS 13.0, *)
    func presentPayment(){
        AppData.appDelegate.navigationController?.pushViewController(AppData.viewControllers[2].viewController, animated: true)
    }
    
    //MARK: PresentCardRegister
    @available(iOS 13.0, *)
    func presentCardRegister(){
        AppData.appDelegate.navigationController?.pushViewController(AppData.viewControllers[1].viewController, animated: true)
    }
    
}
