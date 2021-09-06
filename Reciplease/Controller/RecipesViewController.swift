//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit
import CoreData

class RecipesViewController: BaseViewController {
    
    // MARK: IBOutlet
   
    @IBOutlet weak var noFavoriteView: UIView!
    @IBOutlet weak var recipesTableView: UITableView!
    
    
    // MARK: Properties - Public
    
    var shouldUseFavoriteRecipe = true
    var recipes: [Recipe] = []
    
    // MARK: Properties - Private
    
    private let favoriteRecipeDataManager = FavoriteRecipeDataManager.shared
    
    private var favoritedRecipesList: [RecipeSave] = [] {
        didSet {
            recipesTableView.reloadData()
        }
    }
    private var recipeConvert = RecipeSaveToRecipeConverter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if shouldUseFavoriteRecipe {
            switch favoriteRecipeDataManager.getAll() {
            case .success(let savedRecipes):
                favoritedRecipesList = savedRecipes
            case .failure(let error):
                presentAlert(title: "Error", message: error.localizedDescription)
            }
            handleNoRecipeViewVisibility()
        }
        
        
    }
    
    // MARK: Methods - Private
    
    private func handleNoRecipeViewVisibility() {
        if favoritedRecipesList.count > 0 {
            noFavoriteView.isHidden = true
        } else {
            noFavoriteView.isHidden = false
        }
    }
    
}

extension RecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRowIndex = indexPath.row
        let selectedRecipe: Recipe
        
        if shouldUseFavoriteRecipe {
            let recipeSave = favoritedRecipesList[indexPath.row]
            guard let convertedRecipe = recipeConvert.convert(recipeSave: recipeSave) else {
                return
            }
            selectedRecipe = convertedRecipe
        } else {
            selectedRecipe = recipes[selectedRowIndex]
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let recipeDetailsViewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as? RecipeDetailsViewController else { return }
        recipeDetailsViewController.selectedRecipe = selectedRecipe
        
        self.navigationController?.pushViewController(recipeDetailsViewController, animated: true)
    }
}


extension RecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldUseFavoriteRecipe {
            return favoritedRecipesList.count
        } else {
            return recipes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let cellRecipe: Recipe
        if shouldUseFavoriteRecipe {
            let recipeSave = favoritedRecipesList[indexPath.row]
            guard let convertedRecipe = recipeConvert.convert(recipeSave: recipeSave) else {
                return UITableViewCell()
            }
            cellRecipe = convertedRecipe
        } else {
            
            cellRecipe = recipes[indexPath.row]
        }
        cell.recipeTitleLabel.text = cellRecipe.label
        
        guard let urlImage = URL(string: cellRecipe.image)
        else {
            return cell
        }
        do {
            let data = try Data(contentsOf: urlImage)
            cell.recipeImageView.image = UIImage(data: data)
        } catch _ {
            print("error")
        }
        if let cuisine = cellRecipe.cuisineType {
            cell.cuisineTypeLabel.text = Strings.kindOfMeal +  " : \(cuisine[0].capitalized)"
        }
        else {
            cell.cuisineTypeLabel.text = Strings.kindOfMeal + " : " + Strings.Unknown
        }
        
        cell.caloriesLabel.text = "\(Int(cellRecipe.calories.rounded()))"
        cell.timeLabel.text = "\(cellRecipe.totalTime <= 0 ? "--" : cellRecipe.totalTime.description)"
        
        
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
