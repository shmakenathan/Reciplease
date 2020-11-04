//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    @IBOutlet weak var recipesTableView: UITableView!
    var recipeResult: RecipeResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        
    }

    
}

extension RecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRowIndex = indexPath.row
        guard let selectedRecipe = recipeResult?.hits[selectedRowIndex].recipe else { return }
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let recipeDetailsViewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController else { return }
        recipeDetailsViewController.selectedRecipe = selectedRecipe
        
        self.navigationController?.pushViewController(recipeDetailsViewController, animated: true)
        
        
    }
    
    
}


extension RecipesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeResult?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.recipeTitleLabel.text = recipeResult?.hits[indexPath.row].recipe.label
        guard let urlImage = URL(string : (recipeResult?.hits[indexPath.row].recipe.image)!) else {
            return cell
        }
        do {
            let data = try Data(contentsOf: urlImage)
            cell.recipeImageView.image = UIImage(data: data)
        } catch _ {
            print("error")
        }
        cell.ingredientList.text = recipeResult?.hits[indexPath.row].recipe.ingredientLines[0]
        
        
        let gradient = CAGradientLayer()
        gradient.type = .axial
        
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.8).cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = cell.bounds
        
        gradient.locations = [0.2, 1]
        cell.gradientView.layer.addSublayer(gradient)
        
        
        
        return cell
        
    }
    
    
    
    
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
