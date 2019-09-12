//
//  User.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation

struct Response: Codable {
    let results: [User]
}

struct User: Codable {
    let id: Int
    let name: String
    let img: String
    let username: String
}
