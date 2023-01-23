//
//  self.swift
//  homework11regForm
//
//  Created by Mikhail Chuparnov on 21.01.2023.
//

import UIKit

class TextField: UITextField {
    
    init(placeholder: String, keyboardType: UIKeyboardType) {
        super.init(frame: .zero)
        
        setupProperts(placeholder: placeholder, keyboardType: keyboardType)
        
    }
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProperts(placeholder: String, keyboardType: UIKeyboardType) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 2))
        self.leftView = leftView
        self.leftViewMode = .always
        self.rightView = leftView
        self.rightViewMode = .always
        self.autocapitalizationType = .none
        self.tintColor = .black
        self.textColor = .black
        self.adjustsFontForContentSizeCategory = true
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.clearButtonMode = .whileEditing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
}
