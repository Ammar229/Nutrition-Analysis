//
//  IngredientsSummaryVC.swift
//  Nutrition Analysis
//
//  Created by Ammar on 05/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

class IngredientsSummaryVC: UIViewController, Loadable {
    
    // MARK: - Initialization
    init(viewModel: IngredientsSummaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalNutritionButton: UIButton!
    
    
    // MARK: - Variables
    private var viewModel: IngredientsSummaryViewModel
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.bindVM()
    }
    
    
    // MARK: - UI Functions
    private func configureViews() {
        self.navigationItem.title = "Ingredients Summary"
        tableView.register(UINib(nibName: IngredientDetailsCell.identifier, bundle: nil), forCellReuseIdentifier: IngredientDetailsCell.identifier)
    }
    
    // MARK: - Bind Function
    private func bindVM() {
        bindIngredientsDetails()
        bindButton()
    }
    
    
    
    private func bindIngredientsDetails() {
        // Set tableview delegate. (for setting table view cell height)
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
            
        // Bind Ingredients Details with tableview
        viewModel.ingredientsDetails.asObservable()
            .bind(to: tableView.rx
                .items(cellIdentifier: IngredientDetailsCell.identifier, cellType: IngredientDetailsCell.self))
            { index, ingredientDetails, cell in
                    
                // configure Ingredient Details cell
                cell.ingredientDetails = ingredientDetails
                
                cell.name = "Food Name"
                
        }.disposed(by: disposeBag)
        tableView.tableFooterView = UIView()
    }
    
    private func bindButton() {
        viewModel.isIngredientsDetails.bind(to: totalNutritionButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.color.bind(to: totalNutritionButton.rx.backgroundColor).disposed(by: disposeBag)
    }
    
    
    // MARK: - IBActions
    @IBAction func totalNutritionPressed(_ sender: UIButton) {
        let ingredientsSummaryVC = TotalNutritionVC(viewModel: TotalNutritionViewModel(ingredients:viewModel.getIng))
        self.navigationController?.pushViewController(ingredientsSummaryVC, animated: true)
    }
}


extension IngredientsSummaryVC: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
