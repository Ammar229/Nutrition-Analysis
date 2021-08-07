//
//  AnalyzeIngredientsVC.swift
//  Nutrition Analysis
//
//  Created by Ammar on 02/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

class AnalyzeIngredientsVC: UIViewController, Loadable {
    
    
    // MARK: - Initialization
    init(viewModel: AnalyzeIngredientsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientsTextView: CustomTextView!
    @IBOutlet weak var analyzeButton: UIButton!
    
    // MARK: - Variables
    var viewModel: AnalyzeIngredientsViewModel
    private var disposeBag: DisposeBag = DisposeBag()
 

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.bindVM()
    }
    
    
    // MARK: - UI Functions
    private func configureViews() {
        self.navigationItem.title = "Analyze Ingredients"
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    // MARK: - Bind Function
    private func bindVM() {
        bindIngredientsDetails()
        bindTextView()
        bindButton()
        bindLoadingStatus()
    }
    
    private func bindTextView() {
        ingredientsTextView.rx.text.orEmpty.bind(to: viewModel.text).disposed(by: disposeBag)
        viewModel.text.bind(to: ingredientsTextView.rx.text).disposed(by: disposeBag)
    }
    
    private func bindIngredientsDetails() {
        viewModel.ingredientsDetails.asObservable().subscribe(onNext: { [weak self] ingredientsDetails in
            if ingredientsDetails.isEmpty { return }
            guard let ingredients = self?.viewModel.resultText else { return }
            let vc = IngredientsSummaryVC(viewModel: IngredientsSummaryViewModel(ingredients: ingredients, ingredientsDetails: ingredientsDetails))
            self?.navigationController?.pushViewController(vc, animated: true)
            
        }).disposed(by: disposeBag)
    }
    
    private func bindButton() {
        viewModel.isValidText.bind(to: analyzeButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.color.bind(to: analyzeButton.rx.backgroundColor).disposed(by: disposeBag)
    }
    
    private func bindLoadingStatus() {
        viewModel.loadingStatus.asObservable().subscribe(onNext: { [weak self] dataState in
            guard let self = self else { return }
            switch dataState {
            case .loading:
                self.startLoading()
            case .populated, .empty:
                self.stopLoading()
            case .error(let message):
                self.stopLoading()
                self.presentAlert(message: message)
            }
        }).disposed(by: disposeBag)
    }
    
    
    
    // MARK: - IBActions
    @IBAction func analyzeButtonPressed(_ sender: UIButton) {
        viewModel.analyeText()
    }
    
}

