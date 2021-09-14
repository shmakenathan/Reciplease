//
//  UIViewExtension.swift
//  Reciplease
//
//  Created by Nathan on 06/09/2021.
//  Copyright © 2021 NathanChicha. All rights reserved.
//

import UIKit

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        setupBorder(color: color, frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: width))
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        setupBorder(color: color, frame: CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height))
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        setupBorder(color: color, frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        setupBorder(color: color, frame: CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width))
    }
    
    func setupBorder(color: UIColor, frame: CGRect) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = frame
        self.layer.addSublayer(border)
    }
}

