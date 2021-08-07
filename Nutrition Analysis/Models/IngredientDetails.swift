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
    let totalNutrients, totalDaily: TotalNutrients
}

// MARK: - TotalNutrients
struct TotalNutrients: Codable {
    
    let enercKcal, fat, carbs, fiber: Details
    let protein, cholesterol, na, ca: Details
    let k, fe, vitc: Details
    
    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case fat = "FAT"
        case carbs = "CHOCDF"
        case fiber = "FIBTG"
        case protein = "PROCNT"
        case cholesterol = "CHOLE"
        case na = "NA"
        case ca = "CA"
        case k = "K"
        case fe = "FE"
        case vitc = "VITC"
    }
}

// MARK: - Details
struct Details: Codable {
    let label: String
    let quantity: Double
    let unit: String
}

