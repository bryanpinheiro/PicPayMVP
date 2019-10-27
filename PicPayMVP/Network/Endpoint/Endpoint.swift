//
//  Endpoint.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case base
}

public enum PicPayApi {
    case contatos
    case pagamento(numero: String, cvv: Int, valor: Double, expiracao: String, idContato: Int)
}

extension PicPayApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .base: return "http://careers.picpay.com/tests/mobdev"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .contatos:
            return "/users"
        case .pagamento:
            return "/transaction"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .contatos:
            return .get
        case .pagamento:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .contatos:
            return .request
        case .pagamento(let numero, let cvv, let valor, let expiracao, let idContato):
            return .requestParameters(bodyParameters:
                ["card_number": numero,
                 "cvv": cvv,
                 "value": valor,
                 "expiry_date": expiracao,
                 "destination_user_id": idContato]
                , bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
