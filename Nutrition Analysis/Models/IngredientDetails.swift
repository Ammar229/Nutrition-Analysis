//
//  IngredientDetails.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import Foundation


// MARK: - IngredientDetails
struct IngredientDetails: Codable {
    let uri: String
    let calories, totalWeight: Int
    let totalNutrients: TotalNutrients
}

// MARK: - TotalNutrients
struct TotalNutrients: Codable {
    let enercKcal, fasat: Details

    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case fasat = "FASAT"
    }
}

// MARK: - Details
struct Details: Codable {
    let label: String
    let quantity: Double
    let unit: String
}

