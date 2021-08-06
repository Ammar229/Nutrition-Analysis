//
//  UIView+ReusableIdentifier.swift
//  Nutrition Analysis
//
//  Created by Ammar on 04/08/2021.
//

import UIKit

/// Default identifier added to UIViews
protocol ReusableIdentifier {
    static var identifier: String { get }
}

extension ReusableIdentifier {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

// MARK: UIView+ReusableIdentifier
extension UIView: ReusableIdentifier {}
