//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    var selectedRecipe: Recipe?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var ingredientList: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = selectedRecipe?.label
        printImage()
        getDirectionsButton.layer.cornerRadius = 10
        addGradient(view: gradientView)
    }
    
    @IBAction func addFavori(_ sender: Any) {
    }
    @IBAction func tapToGetDirections(_ sender: Any) {
    }
    private func addGradient(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = view.bounds
        
        gradient.locations = [0.2, 1]
        view.layer.addSublayer(gradient)
        
    }
    private func printImage() {
        
        guard let urlImage = URL(string: (selectedRecipe?.image)!) else {
            return
        }
        do {
            let data = try Data(contentsOf: urlImage)
            imageView.image = UIImage(data: data)
        } catch _ {
            print("error")
            
        }
        
    }
}
extension RecipeDetailsViewController: UITableViewDelegate {
    
}

extension RecipeDetailsViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = selectedRecipe else {
            return 0
        }
        return recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") else {
            return UITableViewCell()
        }
        guard let recipe = selectedRecipe else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "- "+recipe.ingredientLines[indexPath.row].capitalized
        
        return cell
    }
    
    
}
