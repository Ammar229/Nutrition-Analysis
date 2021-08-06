//
//  IngredientsDetailsCell.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import UIKit

class IngredientDetailsCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var totalWeightLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var ingredientDetails: IngredientDetails? {
        didSet {
            guard let ingredientDetails = ingredientDetails else {
                return
            }
            totalWeightLabel.text = "\(ingredientDetails.totalWeight)"
            unitLabel.text = "\(ingredientDetails.totalNutrients.fasat.unit)"
            caloriesLabel.text = "\(ingredientDetails.calories)"
            quantityLabel.text = "\(ingredientDetails.totalNutrients.fasat.quantity)"
        }
    }
    
}
