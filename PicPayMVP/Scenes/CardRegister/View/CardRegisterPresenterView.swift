//
//  CardRegisterPresenterView.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 05/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation

protocol CardRegisterPresenterView: class {
    func startLoading()
    func stopLoading()
    func reloadData()
}
