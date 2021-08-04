//
//  AppCoordinator.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import UIKit

class AppCoordinator {
    
    // MARK: - Variables
    private var window: UIWindow
    
    
    // MARK: - init
    init(window: UIWindow) {
        self.window = window
    }
    
    
    // MARK: - Functions
    func start() {
        window.rootViewController = UINavigationController(rootViewController: AnalyzeIngredientsVC())
        window.makeKeyAndVisible()
    }
    
}

