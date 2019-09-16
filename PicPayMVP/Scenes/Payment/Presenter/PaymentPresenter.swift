//
//  PaymentPresenter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 03/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

class PaymentPresenter {
    
    private(set) weak var view: PaymentPrensenterView!
    var router: PaymentPresenterRouter
    
    //MARK: CONSTRUCTOR
    init(view: PaymentPrensenterView, router: PaymentPresenterRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: Navigation
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        router.prepare(for: segue, sender: sender)
    }
}
