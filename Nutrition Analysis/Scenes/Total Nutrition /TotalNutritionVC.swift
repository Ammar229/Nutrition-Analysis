//
//  TotalNutritionVC.swift
//  Nutrition Analysis
//
//  Created by Ammar on 06/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

class TotalNutritionVC: UIViewController, Loadable {
    
    // MARK: - Initialization
    init(viewModel: TotalNutritionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

 

    // MARK: - Outlets
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var cholesterolLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var vitaminLabel: UILabel!
    @IBOutlet weak var calciumLabel: UILabel!
    @IBOutlet weak var ironLabel: UILabel!
    @IBOutlet weak var potassiumLabel: UILabel!
    
    
    // MARK: - Variables
    private var viewModel: TotalNutritionViewModel
    private var disposeBag: DisposeBag = DisposeBag()
    
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
        self.bindVM()
    }
    
    
    // MARK: - UI Functions
    private func configureViews() {
        self.navigationItem.title = "Total Nutrition"
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    
    // MARK: - Bind Function
    private func bindVM() {
        bindLoadingStatus()
        bindLabels()
        viewModel.getTotalNutritionDetials()
    }
    
    
    private func bindLoadingStatus() {
        viewModel.loadingStatus.asObservable().subscribe(onNext: { [weak self] dataState in
            guard let self = self else { return }
            switch dataState {
            case .loading:
                self.startLoading()
            case .populated:
                self.stopLoading()
            case .error(let message):
                self.stopLoading()
                self.presentAlert(message: message)
            case .empty:
                break
            }
        }).disposed(by: disposeBag)
    }
    
    
    private func bindLabels() {
        viewModel.calories.bind(to: caloriesLabel.rx.text).disposed(by: disposeBag)
        viewModel.fat.bind(to: fatLabel.rx.text).disposed(by: disposeBag)
        viewModel.cholesterol.bind(to: cholesterolLabel.rx.text).disposed(by: disposeBag)
        viewModel.sodium.bind(to: sodiumLabel.rx.text).disposed(by: disposeBag)
        viewModel.carbohydrate.bind(to: carbohydrateLabel.rx.text).disposed(by: disposeBag)
        viewModel.protein.bind(to: proteinLabel.rx.text).disposed(by: disposeBag)
        viewModel.vitamin.bind(to: vitaminLabel.rx.text).disposed(by: disposeBag)
        viewModel.calcium.bind(to: calciumLabel.rx.text).disposed(by: disposeBag)
        viewModel.iron.bind(to: ironLabel.rx.text).disposed(by: disposeBag)
        viewModel.potassium.bind(to: potassiumLabel.rx.text).disposed(by: disposeBag)
    }
    
    

}
