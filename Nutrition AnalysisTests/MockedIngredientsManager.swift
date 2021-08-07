//
//  MockedIngredientsManager.swift
//  Nutrition AnalysisTests
//
//  Created by Ammar on 07/08/2021.
//
 
@testable import Nutrition_Analysis

class MockedIngredientsManager: IngredientsManager {
    var success = false
    
    func getAnalysis(for oneIngredient: String, completion: @escaping (Result<IngredientDetails, Error>) -> Void) {
        if success {
            completion(.success(.stub()))
        } else {
            completion(.failure(APIError.severError("Faild Test")))
        }
        
    }
    
    func getFullRecipeAnalysis(for ingredients: [String], completion: @escaping (Result<IngredientDetails, Error>) -> Void) {
        if success {
            completion(.success(.stub()))
        } else {
            completion(.failure(APIError.severError("Faild Test")))
        }
    }
    
    
}



