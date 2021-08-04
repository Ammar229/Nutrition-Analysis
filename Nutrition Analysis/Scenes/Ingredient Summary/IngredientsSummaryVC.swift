//
//  IngredientSummaryVC.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import UIKit

class IngredientsSummaryVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var viewModel: IngredientsSummaryViewModel = IngredientsSummaryViewModel()
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    
    // MARK: - UI Functions
    private func configureViews() {
        self.navigationItem.title = "Ingredients Summary"
        tableView.dataSource = self
    }
    
    
    // MARK: - Bind Function
    private func bindVM() {
        
    }
    
    
    
    // MARK: - IBActions
    @IBAction func totalNutritionPressed(_ sender: UIButton) {
        
    }
}


extension IngredientsSummaryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}
