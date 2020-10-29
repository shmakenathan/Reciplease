//
//  ViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit



class FridgeViewController: BaseViewController {
    
    
    @IBOutlet weak var ingredientUiTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var searchTapButton: UIButton!
    
    
    @IBAction func addTapButton(_ sender: Any) {
        guard let ingredient = ingredientUiTextField.text else { return }
        do {
            try addIngredienttoList(ingredient: ingredient)
        } catch {
            presentAlert(title: "Error", message: RecipleaseError.ingredientAlreadyPresent.message)
        }
    }
    
    @IBAction func searchTapButton(_ sender: Any) {
        if ingredients.isEmpty {
            presentAlert(title: "Error", message: RecipleaseError.noIngredient.message)
        }
        self.changeLoadingIndicatorVisibility(shouldShow: true)
        recipeNetworkManager.fetchRecipe(
            ingredients: ingredients,
            completionHandler: handleRecipeResult(result:)
        )
    }
    
    private func handleRecipeResult(result: Result<RecipeResult, NetworkManagerError>) {
        DispatchQueue.main.async {
            switch result {
            case .failure(let erreur):
                self.changeLoadingIndicatorVisibility(shouldShow: false)
                self.presentAlert(title: "Error", message: erreur.message)
                
            case .success(let recipeResult):
                self.changeLoadingIndicatorVisibility(shouldShow: false)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let recipesViewController = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as? RecipesViewController else { return }
                recipesViewController.recipeResult = recipeResult
                
                
                self.navigationController?.pushViewController(recipesViewController, animated: true)
            }
        }
    }
    private let recipeNetworkManager = RecipeNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTapButton.layer.cornerRadius = 10
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        ingredientUiTextField.addBottomBorderWithColor(color: .gray, width: 1)
    }
    
    
    
    // datasource
    
    private func addIngredienttoList(ingredient: String) throws {
        guard !ingredients.contains(ingredient.capitalized) else {
            throw RecipleaseError.ingredientAlreadyPresent
        }
        ingredients.append(ingredient.capitalized)
    }
    
    
    private var ingredients: [String] = [] {
        didSet {
            ingredientsTableView.reloadData()
        }
    }
}



extension FridgeViewController: UITableViewDelegate {
    
}

extension FridgeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "- "+ingredients[indexPath.row]
        
        return cell
    }
    
    
}
