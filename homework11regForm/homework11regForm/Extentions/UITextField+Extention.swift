//
//  UITextField+Extention.swift
//  homework11regForm
//
//  Created by Mikhail Chuparnov on 21.01.2023.
//

import UIKit

extension UITextField {
    func shakeTextFieldifEmpty(){
        if self.text == "" {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 3
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
            self.layer.add(animation, forKey: "position")
        }
    }
}
