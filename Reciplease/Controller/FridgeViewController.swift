//
//  ViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit

enum FridgeError: Error {
    case ingredientAlreadyPresent
}

class FridgeViewController: UIViewController {
    
    
    @IBOutlet weak var ingredientUiTextField: UITextField!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    @IBOutlet weak var searchTapButton: UIButton!
    @IBAction func addTapButton(_ sender: Any) {
        
        guard let ingredient = ingredientUiTextField.text else { return }
        
        do {
            try addIngredienttoList(ingredient: ingredient)
        } catch {
            print("should display alert error")
        }
        
    }
    
    @IBAction func searchTapButton(_ sender: Any) {
        recipeNetworkManager.fetchRecipe(ingredient: toString(ingredient: ingredients), completionHandler: handleRecipeResult(result:))
    }
    
    private func handleRecipeResult(result: Result<RecipeResult, NetworkManagerError>) {
        DispatchQueue.main.async {
            switch result {
            case .failure(let _):
                print("error")
            case .success(let RecipeResult):
                print(RecipeResult)
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
        guard !ingredients.contains(ingredient) else {
            throw FridgeError.ingredientAlreadyPresent
        }
        ingredients.append(ingredient)
    }
    
    func toString(ingredient: [String]) -> String {
        var list = ""
        if ingredient.count > 0 {
            for i in ingredient {
                list = list + i + " "
            }
            
        }
        return list
    }
    
    var ingredients: [String] = [
        
    ] {
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
