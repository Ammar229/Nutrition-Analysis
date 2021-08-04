//
//  CustomTextView.swift
//  Nutrition Analysis
//
//  Created by Ammar on 02/08/2021.
//

import UIKit

@IBDesignable
class CustomTextView: UITextView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateBorder()
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    private func updateBorder() {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
