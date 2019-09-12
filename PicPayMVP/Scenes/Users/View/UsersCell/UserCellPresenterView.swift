//
//  UserCellPresenterView.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 30/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation
import UIKit

protocol UserCellPresenterView: class {
    func displayImage(image: UIImage)
    func displayLabels(username: String, name: String)
}
