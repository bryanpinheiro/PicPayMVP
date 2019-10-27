//
//  Transaction.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/09/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation

struct ResponseTransaction: Codable {
    let transaction: Transaction
}

struct Transaction: Codable {
    let id, timestamp: Int
    let value: Double
    let destinationUser: DestinationUser
    let success: Bool
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id, timestamp, value
        case destinationUser = "destination_user"
        case success, status
    }
}

struct DestinationUser: Codable {
    let id: Int
    let name: String
    let img: String
    let username: String
}
