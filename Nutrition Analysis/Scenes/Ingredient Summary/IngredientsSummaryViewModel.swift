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
    init(ingredients: [String]) {
        self.ingredients = ingredients
    }
    
    // MARK: - Variables
    private var ingredientsManager: IngredientsManager = IngredientsNetworkManager()
    private var ingredients :[String]
    var ingredientsDetails: BehaviorRelay<[IngredientDetails]> = .init(value: [])
    var loadingStatus: BehaviorRelay<DataState> = .init(value: .empty)
    // create observable
    var isIngredientsDetails: Observable<Bool> {
        return ingredientsDetails.map{ !$0.isEmpty }
    }
    var color: Observable<UIColor> {
        return ingredientsDetails.map{ $0.isEmpty ? .lightGray : .blue }
    }
    
    
   
    // MARK: - API Functions
    func getIngredientsDetials() {
        self.loadingStatus.accept(.loading)
        let group = DispatchGroup()
        var ingredientsDetails: [IngredientDetails] = []
        for ingredient in ingredients {
            group.enter()
            ingredientsManager.getAnalysis(for: ingredient) { result in
                switch result {
                case .success(let ingredientDetails):
                    ingredientsDetails.append(ingredientDetails)
                case .failure(let error):
                    self.loadingStatus.accept(.error(error.localizedDescription))
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.ingredientsDetails.accept(ingredientsDetails)
            self.loadingStatus.accept(.populated)
        }
    }
}
