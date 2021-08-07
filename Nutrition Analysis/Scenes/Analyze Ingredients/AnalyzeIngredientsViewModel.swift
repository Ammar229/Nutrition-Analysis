//
//  AnalyzeIngredientsViewModel.swift
//  Nutrition Analysis
//
//  Created by Ammar on 02/08/2021.
//

import Foundation
import RxSwift
import RxRelay

class AnalyzeIngredientsViewModel {
    
    
    // MARK: - Initialization
    init(ingredientsManager: IngredientsManager = IngredientsNetworkManager()) {
        self.ingredientsManager = ingredientsManager
    }
    
    // MARK: - Variables
    private var ingredientsManager: IngredientsManager
    var text: BehaviorRelay<String> = .init(value: "")
    var isValidText: Observable<Bool> {
        return text.map{ !$0.isEmpty } // create observable
    }
    var color: Observable<UIColor> {
        return text.map{ $0.isEmpty ? .lightGray : .blue }
    }

    var resultText: [String]?
    var loadingStatus: BehaviorRelay<DataState> = .init(value: .empty)
    var ingredientsDetails: BehaviorRelay<[IngredientDetails]> = .init(value: [])
 
    // MARK: - Functions
    func analyeText() {
        resultText = text.value.components(separatedBy: "\n")
        guard let resultText = resultText else {
            return
        }
        self.getIngredientsDetials(for: resultText)
        self.text.accept("")
    }
    
    
    // MARK: - API Functions
    func getIngredientsDetials(for ingredients: [String]) {
        self.loadingStatus.accept(.loading)
        let group = DispatchGroup()
        var ingredientsDetails: [IngredientDetails] = []
        for ingredient in ingredients {
            group.enter()
            ingredientsManager.getAnalysis(for: ingredient) { [weak self] result in
                guard let self = self else { return }
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
            switch self.loadingStatus.value {
            case .error:
                break
            default:
                self.loadingStatus.accept(.populated)
            }
            
        }
    }
    
    
    
    
    
    
}
