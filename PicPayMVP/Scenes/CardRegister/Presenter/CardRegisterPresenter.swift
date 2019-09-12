//
//  CardRegisterPresenter.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 05/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

class CardRegisterPresenter {
    private(set) weak var view: CardRegisterPresenterView!
    private weak var scrollView: UIScrollView!
    private var router: CardRegisterRouter
    
    init(view: CardRegisterPresenterView, router: CardRegisterRouter) {
        self.view = view
        self.router = router
    }
    
    //MARK: Functions
    
    
    //MARK: Navigation
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        router.prepare(for: segue, sender: sender)
    }
}
