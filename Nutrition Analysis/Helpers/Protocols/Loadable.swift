//
//  Loadable.swift
//  Nutrition Analysis
//
//  Created by Ammar on 05/08/2021.
//

import UIKit

protocol Loadable {
    // Loading indicator
    func startLoading(activityIndicator: UIActivityIndicatorView)
    func stopLoading(activityIndicator: UIActivityIndicatorView)
}

extension Loadable where Self: UIViewController {
    // Loading indicator
    func startLoading(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.startAnimating()
    }
    
    func stopLoading(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
