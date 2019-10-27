//
//  CardRegisterOneViewController.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 30/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import UIKit

class CardRegisterOneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(_ sender: Any) {
        AppData.appDelegate.navigationController?.viewControllers.removeLast()
    }
    
    @IBAction func Next(_ sender: Any) {
        if #available(iOS 13.0, *) {
            AppData.appDelegate.navigationController?.pushViewController(AppData.viewControllers[1].subViewControllers![0], animated: true)
        }
    }
    
}
