//
//  IngredientsSummaryViewModel.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import Foundation
import RxSwift
import RxRelay

class IngredientsSummaryViewModel {
    
    // MARK: - Initialization
    init(ingredients: [String], ingredientsDetails: [IngredientDetails]) {
        self.ingredients = ingredients
        self.ingredientsDetails.accept(ingredientsDetails)
    }
    
    // MARK: - Variables
    private var ingredients: [String]
    var ingredientsDetails: BehaviorRelay<[IngredientDetails]> = .init(value: [])
    var loadingStatus: BehaviorRelay<DataState> = .init(value: .empty)
    // create observable
    var isIngredientsDetails: Observable<Bool> {
        return ingredientsDetails.map{ !$0.isEmpty }
    }
    var color: Observable<UIColor> {
        return ingredientsDetails.map{ $0.isEmpty ? .lightGray : .blue }
    }
    
    var getIng: [String] {
        return ingredients
    }
}
