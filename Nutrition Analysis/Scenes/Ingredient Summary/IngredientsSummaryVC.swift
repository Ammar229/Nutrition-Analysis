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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var totalNutritionButton: UIButton!
    
    
    // MARK: - Variables
    private var viewModel: IngredientsSummaryViewModel
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.bindVM()
        self.viewModel.getIngredientsDetials()
    }
    
    
    // MARK: - UI Functions
    private func configureViews() {
        self.navigationItem.title = "Ingredients Summary"
        tableView.register(UINib(nibName: IngredientDetailsCell.identifier, bundle: nil), forCellReuseIdentifier: IngredientDetailsCell.identifier)
    }
    
    
    // MARK: - Bind Function
    private func bindVM() {
        bindLoadingStatus()
        bindIngredientsDetails()
        bindButton()
    }
    
    private func bindLoadingStatus() {
        viewModel.loadingStatus.asObservable().subscribe(onNext: { [weak self] dataState in
            guard let self = self else { return }
            switch dataState {
            case .loading:
                self.startLoading(activityIndicator: self.activityIndicator)
            case .populated:
                self.stopLoading(activityIndicator: self.activityIndicator)
            case .error(let message):
                self.stopLoading(activityIndicator: self.activityIndicator)
                self.presentAlert(message: message)
            case .empty:
                break
            }
        }).disposed(by: disposeBag)
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
                
        }.disposed(by: disposeBag)
        tableView.tableFooterView = UIView()
    }
    
    private func bindButton() {
        viewModel.isIngredientsDetails.bind(to: totalNutritionButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.color.bind(to: totalNutritionButton.rx.backgroundColor).disposed(by: disposeBag)
    }
    
    
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    @IBAction func totalNutritionPressed(_ sender: UIButton) {
        debugPrint("test")
    }
}


extension IngredientsSummaryVC: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
