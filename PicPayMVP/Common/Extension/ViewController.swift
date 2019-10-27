//
//  ViewController.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 30/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: SetupNavigationBar
    func setupNavigation(){
        let nav = navigationController?.navigationBar
        nav?.backIndicatorImage = #imageLiteral(resourceName: "outline_arrow_back_ios_black_18pt")
        nav?.tintColor = UIColor(red: 0.07, green: 0.78, blue: 0.44, alpha: 1)
        nav?.topItem?.title = ""
    }
    
}
