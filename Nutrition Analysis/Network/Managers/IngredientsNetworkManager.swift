//
//  IndividualIngredientNetworkManager.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import Foundation
import Moya

protocol IngredientsManager {
    func getAnalysis(for oneIngredient: String, completion: @escaping (Result<IngredientDetails, Error>) -> Void)
}


class IngredientsNetworkManager: IngredientsManager, HandleNetworkManager {
    
    private var moyaProvider: MoyaProvider<IngredientsService>
    init(_ moyaProvider: MoyaProvider<IngredientsService> = MoyaProvider<IngredientsService>()) {
        self.moyaProvider = moyaProvider
    }
    
    
    func getAnalysis(for oneIngredient: String, completion: @escaping (Result<IngredientDetails, Error>) -> Void) {
        moyaProvider.request(.getAnalysis(oneIngredient: oneIngredient)) { [weak self] result in
            self?.handleNetworkResponse(result: result, completion: completion)
        }
    }
}
