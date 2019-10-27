//
//  Data.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 03/10/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

struct AppData {
    static var User: User? = nil
    static var Image: UIImage? = nil
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @available(iOS 13.0, *)
    //Store viewControllers
    static var viewControllers: [StackViewController] = [
        StackViewController(viewController: UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "UserViewController"), subViewControllers: nil),
        StackViewController(viewController: UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "CardRegisterOneViewController"), subViewControllers: [UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "CardRegisterViewController")]),
        StackViewController(viewController: UIStoryboard(name: "User", bundle: nil).instantiateViewController(identifier: "PaymentViewController"), subViewControllers: nil)
    ]
}

struct StackViewController{
    var viewController: UIViewController
    var subViewControllers: [UIViewController]?
}
