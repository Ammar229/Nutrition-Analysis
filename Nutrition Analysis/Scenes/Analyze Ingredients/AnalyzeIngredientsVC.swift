//
//  AnalyzeIngredientsVC.swift
//  Nutrition Analysis
//
//  Created by Ammar on 02/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

class AnalyzeIngredientsVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientsTextView: CustomTextView!
    @IBOutlet weak var analyzeButton: UIButton!
    
    
    // MARK: - Variables
    var viewModel: AnalyzeIngredientsViewModel = AnalyzeIngredientsViewModel()
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
    
    
    // MARK: - Bind Function
    private func bindVM() {
        bindTextView()
        bindButton()
    }
    
    private func bindTextView() {
        ingredientsTextView.rx.text.orEmpty.bind(to: viewModel.text).disposed(by: disposeBag)
        viewModel.resultText.asObservable().subscribe(onNext: { resultText in
            // navigate to next view with result text
            debugPrint(resultText)
        }).disposed(by: disposeBag)
    }
    
    private func bindButton() {
        viewModel.isValidText.bind(to: analyzeButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.color.bind(to: analyzeButton.rx.backgroundColor).disposed(by: disposeBag)
    }
    
    
    
    // MARK: - IBActions
    @IBAction func analyzeButtonPressed(_ sender: UIButton) {
        viewModel.analyeText()
    }
    
}

