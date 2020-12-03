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
    var recipeResult: RecipeResult?
    
    // MARK: Properties - Private
    
    private let favoriteRecipeDataManager = FavoriteRecipeDataManager()
  
    private var favoritedRecipesList: [RecipeSave] = [] {
        didSet {
            recipesTableView.reloadData()
        }
    }
    private var recipeConvert = RecipeSaveToRecipe()
    
    
    
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
            ifHaveFavorite()
        }
        
        
    }
    
    // MARK: Methods - Private
    
    private func ifHaveFavorite(){
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
            guard let selectedRecipeFromResult = recipeResult?.hits[selectedRowIndex].recipe else { return }
            selectedRecipe = selectedRecipeFromResult
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
            return recipeResult?.hits.count ?? 0
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
            guard let cellRecipeFromResult = recipeResult?.hits[indexPath.row].recipe else {
                return UITableViewCell()
            }
            
            cellRecipe = cellRecipeFromResult
        }
        cell.recipeTitleLabel.text = cellRecipe.label
        
        guard let urlImage = URL(string: cellRecipe.image) else {
            return cell
        }
        do {
            let data = try Data(contentsOf: urlImage)
            cell.recipeImageView.image = UIImage(data: data)
        } catch _ {
            print("error")
        }
        
        cell.ingredientList.text = "\(cellRecipe.totalTime) Minutes"
        
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
