//
//  Label.swift
//  homework11regForm
//
//  Created by Mikhail Chuparnov on 23.01.2023.
//

import UIKit

class Label: UILabel {

    init(ofSize: CGFloat, weight: UIFont.Weight) {
        super.init(frame: .zero)
        setupProperts(ofSize: ofSize, weight: weight)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProperts(ofSize: CGFloat, weight: UIFont.Weight) {
        self.textAlignment = .natural
        self.font = UIFont.systemFont(ofSize: ofSize, weight: weight)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupData(text: String) {
        self.text = text
    }
}
