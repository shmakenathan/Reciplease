//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}






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
