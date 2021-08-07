//
//  Stubs.swift
//  Nutrition AnalysisTests
//
//  Created by Ammar on 08/08/2021.
//

import Foundation
@testable import Nutrition_Analysis

extension IngredientDetails {
    static func stub() -> IngredientDetails {
        .init(uri: "", calories: 120, totalWeight: 50, totalNutrients: .stub(), totalDaily: .stub())
    }
}

extension TotalNutrients {
    static func stub() -> TotalNutrients {
        .init(enercKcal: .stub(), fat: .stub(), carbs: .stub(), fiber: .stub(), protein: .stub(), cholesterol: .stub(), na: .stub(), ca: .stub(), k: .stub(), fe: .stub(), vitc: .stub())
    }
    
}

extension Details {
    static func stub() -> Details {
        .init(label: "Test Lable", quantity: 19.5, unit: "g")
    }
}
