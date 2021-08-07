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
    case getFullRecipeAnalysis(ingredients: [String])
}


extension IngredientsService: TargetType {
    var baseURL: URL {
        return URL (string: "https://api.edamam.com")!
    }
    
    var path: String {
        switch self {
        case .getAnalysis:
            return "/api/nutrition-data"
        case .getFullRecipeAnalysis:
            return "/api/nutrition-details"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAnalysis:
            return .get
        case .getFullRecipeAnalysis:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAnalysis(let ingredient):
            let params: [String: Any] = ["app_id": SharedData.shared.appID,
                      "app_key": SharedData.shared.appkey, "ingr" : ingredient, "nutrition-type": "cooking"]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getFullRecipeAnalysis(ingredients: let ingredients):
            let urlParameters: [String: Any] = ["app_id": SharedData.shared.appID,
                                                "app_key": SharedData.shared.appkey]
            let bodyParameters: [String: Any] = ["title": SharedData.shared.meal,
                                                 "ingr": ingredients]
            return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)
        }

    }
    
    var headers: [String : String]? {
        var httpHeaders: [String: String] = [:]
        httpHeaders["Content-Type"] = "application/json"
        return httpHeaders
    }
}
