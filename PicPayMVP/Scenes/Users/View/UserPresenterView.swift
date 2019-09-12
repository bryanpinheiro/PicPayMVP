//
//  UserPresenterView.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 30/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation

protocol UserPresenterView: class {
    func startLoading()
    func stoploading()
    func reloadData()
}
