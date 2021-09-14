//
//  ViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit



class FridgeViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var yourIngredient: UILabel!
    @IBOutlet private weak var whatsInYourFridge: UILabel!
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var ingredientsTableView: UITableView!
    @IBOutlet private weak var searchTapButton: UIButton!
    
    // MARK: IBAction
    
    @IBAction func tapToResignKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
    
    @IBAction func addTapButton(_ sender: Any) {
        guard let ingredient = ingredientTextField.text else { return }
        switch fridgeService.addIngredient(ingredient) {
        case .success(): break
        case .failure(let error): handleError(error: error)
        }
        ingredientTextField.text = ""
    }
    
    @IBAction func deleteTapButton(_ sender: Any) {
        fridgeService.clearIngredients()
    }
    
    @IBAction func searchTapButton(_ sender: Any) {
        searchTapButton.isEnabled = false
        searchTapButton.alpha = 0.6
        
        if fridgeService.ingredients.isEmpty {
            searchTapButton.isEnabled = true
            searchTapButton.alpha = 1.0
            presentAlert(title: "Error", message: RecipleaseError.noIngredient.message)
        }
        self.changeLoadingIndicatorVisibility(shouldShow: true)
        fridgeService.searchRecipes(completionHandler: handleRecipeResult)
    }
    
    
   
    // MARK: Properties - Private
    
    
    private let fridgeService = FridgeService()
    private let recipeNetworkManager = RecipeNetworkManager()
    
    // MARK: Methods - Private
    
    private func handleError(error: FridgeServiceError) {
        presentAlert(title: Strings.error, message: error.message)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Strings.titleFridge
        yourIngredient.text = Strings.yourIngredient
        whatsInYourFridge.text = Strings.whatsInYourFridge
        searchTapButton.setTitle(Strings.searchForRecipe, for: .normal)
        searchTapButton.layer.cornerRadius = 10
        fridgeService.delegate = self
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ingredientTextField.addBottomBorderWithColor(color: .gray, width: 1)
    }
    
    
    func handleRecipeResult(result: Result<[Recipe], FridgeServiceError>) {
        DispatchQueue.main.async {
            self.searchTapButton.isEnabled = true
            self.searchTapButton.alpha = 1.0
            
            switch result {
            case .failure(let erreur):
                self.changeLoadingIndicatorVisibility(shouldShow: false)
                self.presentAlert(title: Strings.error, message: erreur.message)
                
            case .success(let recipes):
                self.changeLoadingIndicatorVisibility(shouldShow: false)
                if recipes.count == 0 {
                    self.presentAlert(title: Strings.error, message: RecipleaseError.noResults.message)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let recipesViewController = storyboard.instantiateViewController(withIdentifier: "RecipesViewController") as? RecipesViewController else { return }
                    recipesViewController.recipes = recipes
                    recipesViewController.shouldUseFavoriteRecipe = false
                    self.navigationController?.pushViewController(recipesViewController, animated: true)
                }
            }
        }
    }
   
}

extension FridgeViewController: FridgeServiceDelegate {
    
    
    func didUpdateIngredients() {
        ingredientsTableView.reloadData()
    }
    
    
}


extension FridgeViewController: UITableViewDelegate {
    
}

extension FridgeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fridgeService.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "- "+fridgeService.ingredients[indexPath.row].capitalized
        return cell
    }
    
    
}
