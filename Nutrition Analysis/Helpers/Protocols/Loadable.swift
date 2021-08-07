//
//  Loadable.swift
//  Nutrition Analysis
//
//  Created by Ammar on 05/08/2021.
//

import UIKit
import MBProgressHUD

protocol Loadable {
    // Loading indicator
    func startLoading()
    func stopLoading()
}

extension Loadable where Self: UIViewController {
    // Loading indicator
    func startLoading() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func stopLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
