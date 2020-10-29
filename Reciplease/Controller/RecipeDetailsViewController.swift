//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ingredientList: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBAction func tapToGetDirections(_ sender: Any) {
    }
    
}
