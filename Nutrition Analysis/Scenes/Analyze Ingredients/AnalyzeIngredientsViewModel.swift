//
//  AnalyzeIngredientsViewModel.swift
//  Nutrition Analysis
//
//  Created by Ammar on 02/08/2021.
//

import Foundation
import RxSwift
import RxRelay

class AnalyzeIngredientsViewModel {
    
    // MARK: - Variables
    var text: BehaviorRelay<String> = .init(value: "")
    var resultText: BehaviorRelay<[String]> = .init(value: [])
    var isValidText: Observable<Bool> {
        return text.map{ !$0.isEmpty } // create observable
    }
    var color: Observable<UIColor> {
        return text.map{ $0.isEmpty ? .lightGray : .blue }
    }

    
 
    // MARK: - Functions
    func analyeText() {
        let resultText = text.value.components(separatedBy: "\n")
        self.resultText.accept(resultText)
    }

}
