//
//  Manager.swift
//  PicPayMVP
//
//  Created by Bryan Souza on 17/08/19.
//  Copyright © 2019 Bryan Souza. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    
    static let shared = NetworkManager()
    static let environment : NetworkEnvironment = .base
    let router = Router<PicPayApi>()
    
    //MASK: GET
    func getContatos(completion: @escaping ([User]?, String?) -> Void){
        router.request(.contatos) { data, response, error in
            if error != nil {
                completion(nil, "Por favor, verifique sua conexão de rede.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let json = try JSONDecoder().decode([User].self, from: responseData)
                        completion(json, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    //POST
    func payment(numero: String, cvv: Int, valor: Double, expiracao: String, idContato: Int, completion: @escaping (ResponseTransaction?, String?) -> Void) {
        router.request(.pagamento(numero: numero, cvv: cvv, valor: valor, expiracao: expiracao, idContato: idContato)) { (data, response, error) in
            
            if error != nil {
                completion(nil, "Por favor, verifique sua conexão de rede.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let json = try JSONDecoder().decode(ResponseTransaction.self, from: responseData)
                        completion(json, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
