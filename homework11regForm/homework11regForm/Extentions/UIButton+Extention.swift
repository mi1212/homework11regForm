//
//  UIButton+Extention.swift
//  homework11regForm
//
//  Created by Mikhail Chuparnov on 23.01.2023.
//

import UIKit

extension UIButton {
    func animationTapButton(){
        
        let time = 0.06
        
        let scale = 0.95
        
        UIView.animate(withDuration: time, delay: 0) {
            self.transform = self.transform.scaledBy(x: scale, y: scale)
        } completion: { handler in
            UIView.animate(withDuration: time, delay: 0) {
                self.transform = self.transform.scaledBy(x: 1/scale, y: 1/scale)
            }
        }
    }
}
