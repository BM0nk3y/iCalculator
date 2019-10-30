//
//  UIButtonExtension.swift
//  iCalculator
//
//  Created by Abel Lazaro on 30/10/19.
//  Copyright © 2019 Abel Lázaro. All rights reserved.
//

import UIKit

extension UIButton {

    // Borde redondo
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    // Brilla
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) { (completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
    
}
