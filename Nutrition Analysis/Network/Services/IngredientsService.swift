//
//  IndividualIngredientService.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import Foundation
import Moya

enum IngredientsService {
    case getAnalysis(oneIngredient: String)
}


extension IngredientsService: TargetType {
    var baseURL: URL {
        return URL (string: "https://api.edamam.com")!
    }
    
    var path: String {
        return "/api/nutrition-data"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAnalysis(let ingredient):
            let params: [String: Any]
            params = ["app_id": SharedData.shared.appID,
                      "app_key": SharedData.shared.appkey, "ingr" : ingredient] as [String : Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }

    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        httpHeaders["Content-Type"] = "application/json"
        return httpHeaders
    }
}
