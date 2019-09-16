//
//  Endpoint.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
    case payment
}

public enum PicPayApi {
    case popular
}

extension PicPayApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "http://careers.picpay.com/tests/mobdev/users"
        case .payment: return "http://careers.picpay.com/tests/mobdev/transaction"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .popular:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .popular:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
