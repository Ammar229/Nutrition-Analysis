//
//  HandleNetworkManager.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import Foundation
import Moya

protocol HandleNetworkManager {
    func handleNetworkResponse<T: Codable>(result: (Result<Moya.Response, MoyaError>), completion: (Result<T, Error>)  -> Void)
    func parsingResponse<T: Codable>(_ response: Response, completion: (Result<T, Error>)  -> Void)
}


extension HandleNetworkManager {
    func handleNetworkResponse<T: Codable>(result: (Result<Moya.Response, MoyaError>), completion: (Result<T, Error>)  -> Void) {
        switch result {
        case .success(let response):
            parsingResponse(response, completion: completion)
        case .failure(let error):
            completion(.failure(error))
        }
    }


    func parsingResponse<T: Codable>(_ response: Response, completion: (Result<T, Error>)  -> Void) {
        guard let responseString = String(data: response.data, encoding: .utf8) else {
            completion(.failure(APIError.parsing))
            return
        }
        let jsonData = Data(responseString.utf8)
        let decoder = JSONDecoder()
        
        switch response.statusCode {
             case 200...299:
                    do {
                         let data = try decoder.decode(T.self, from: jsonData)
                         completion(.success(data))
                      } catch {
                         completion(.failure(APIError.severError(ErrorNetworkMessage.noData.rawValue)))
                      }

             case 400...499:
                let data = try! decoder.decode(ErrorResponse.self, from: jsonData)
                completion(.failure(APIError.severError(data.message ?? "Server Error")))
                
             case 500...599: completion(.failure(APIError.severError(ErrorNetworkMessage.badRequest.rawValue)))
             case 600: completion(.failure(APIError.severError(ErrorNetworkMessage.outdated.rawValue)))
             default: completion(.failure(APIError.severError(ErrorNetworkMessage.failed.rawValue)))
        }
    }
}





















