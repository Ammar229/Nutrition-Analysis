//
//  TotalNutritionViewModel.swift
//  Nutrition Analysis
//
//  Created by Ammar on 06/08/2021.
//

import Foundation
import RxSwift
import RxRelay


class TotalNutritionViewModel {
    
    // MARK: - Initialization
    init(ingredients: [String]) {
        self.ingredients = ingredients
    }
    
    // MARK: - Variables
    private var ingredientsManager: IngredientsManager = IngredientsNetworkManager()
    private var ingredients :[String]
    var calories: BehaviorRelay<String> = .init(value: "")
    var fat: BehaviorRelay<String> = .init(value: "")
    var cholesterol: BehaviorRelay<String> = .init(value: "")
    var sodium: BehaviorRelay<String> = .init(value: "")
    var carbohydrate: BehaviorRelay<String> = .init(value: "")
    var protein: BehaviorRelay<String> = .init(value: "")
    var vitamin: BehaviorRelay<String> = .init(value: "")
    var calcium: BehaviorRelay<String> = .init(value: "")
    var iron: BehaviorRelay<String> = .init(value: "")
    var potassium: BehaviorRelay<String> = .init(value: "")
    
    
    var ingredientDetails: IngredientDetails? {
        didSet {
            guard let ingredientDetails = ingredientDetails else { return }
            calories.accept(getPresnt(of: ingredientDetails.totalDaily.enercKcal.quantity))
            fat.accept(getPresnt(of: ingredientDetails.totalDaily.fat.quantity))
            cholesterol.accept(getPresnt(of: ingredientDetails.totalDaily.cholesterol.quantity))
            sodium.accept(getPresnt(of: ingredientDetails.totalDaily.na.quantity))
            carbohydrate.accept(getPresnt(of: ingredientDetails.totalDaily.carbs.quantity) + ", "+getPresnt(of: ingredientDetails.totalDaily.fiber.quantity))
            protein.accept(getPresnt(of: ingredientDetails.totalDaily.protein.quantity))
            vitamin.accept(getPresnt(of: ingredientDetails.totalDaily.vitc.quantity))
            calcium.accept(getPresnt(of: ingredientDetails.totalDaily.ca.quantity))
            iron.accept(getPresnt(of: ingredientDetails.totalDaily.fe.quantity))
            potassium.accept(getPresnt(of: ingredientDetails.totalDaily.k.quantity))
        }
    }
    var loadingStatus:BehaviorRelay<DataState> = .init(value: .empty)

    
    
   
    // MARK: - API Functions
    func getTotalNutritionDetials() {
        self.loadingStatus.accept(.loading)
        ingredientsManager.getFullRecipeAnalysis(for: ingredients) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let ingredientDetails):
                self.loadingStatus.accept(.populated)
                self.ingredientDetails = ingredientDetails
            case .failure(let error):
                self.loadingStatus.accept(.error(error.localizedDescription))
            }
        }
    }
    
  
    func getPresnt(of: Double) -> String {
        return " \(Double(round(1000*of)/1000)) %"
    }
}



