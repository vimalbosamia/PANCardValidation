//
//  UIHelper.swift
//  Pan
//
//  Created by Vimal Bosamiya on 07/03/24.
//

import UIKit

class UIHelper {
    static func updateTextFieldBorder(textField: UITextField, isValid: Bool) {
        DispatchQueue.main.async {
            let color: UIColor = isValid ? .systemBlue : .red
            textField.layer.borderColor = color.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 5.0
            
        }
    }
}


@IBDesignable class DesignableTextField: UITextField {
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.height))
        leftView = leftPaddingView
        leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: self.frame.height))
        rightView = rightPaddingView
        rightViewMode = .always
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateView()
    }
}
