//
//  PaymentPresenterRouter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 03/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

class PaymentPresenterRouter {
    //MARK: Properties
    private let cardRegister = "cardregister"
    private weak var viewController: PaymentViewController?

    init(_ viewController: PaymentViewController) {
        self.viewController = viewController
    }
    
    //MARK: Navigation
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("calling card register")
    }
}
