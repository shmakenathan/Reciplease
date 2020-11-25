//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailsViewController: UIViewController {
    
    var selectedRecipe: Recipe?
    let favoriteRecipeDataManager = ServiceContainer.favoriteRecipeDataManager
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var ingredientList: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = selectedRecipe?.label
        printImage()
        getDirectionsButton.layer.cornerRadius = 10
        addGradient(view: gradientView)
    }
    
    @IBAction func addFavori(_ sender: Any) {
        switch favoriteBarButtonItem.image {
        case UIImage(systemName: "star"):
            favoriteBarButtonItem.image = UIImage(systemName: "star.fill")
            guard let recipe = selectedRecipe else {
                return
            }
            favoriteRecipeDataManager.save(recipeToSave: recipe)
        default:
            favoriteBarButtonItem.image = UIImage(systemName: "star")
        }
        
        
    }
    
    @IBAction func tapToGetDirections(_ sender: Any) {
        guard let urlSelectedRecipe = selectedRecipe?.url else {
            return
        }
        if let url = URL(string: urlSelectedRecipe) {
            UIApplication.shared.open(url)
        }
    }
    
    private func addGradient(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.darkGray.withAlphaComponent(1).cgColor
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
