//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Nathan on 08/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import UIKit
import CoreData

class RecipeDetailsViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var ingredientList: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    
    // MARK: IBAction
    
    @IBAction func didTapOnFavoriteBarButton(_ sender: Any) {
        guard let selectedRecipe = selectedRecipe else { return }
        if isPresentedRecipeFavorited {
            deleteSelectedRecipe(selectedRecipe)
        } else {
            saveSelectedRecipe(selectedRecipe)
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
    
    // MARK: Properties - Public
    
    var selectedRecipe: Recipe?
    
    // MARK: Properties - Private
    
    private let favoriteRecipeDataManager = FavoriteRecipeDataManager.shared
    private var isPresentedRecipeFavorited = false {
        didSet {
            favoriteBarButtonItem.image = isPresentedRecipeFavorited ?
                UIImage(systemName: "star.fill") :
                UIImage(systemName: "star")
        }
    }
    
    
    // MARK: Methods - Private
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDirectionsButton.setTitle(Strings.getDirections, for: .normal)
        self.navigationItem.title = Strings.titleRecipeDetails
        titleLabel.text = selectedRecipe?.label
        printImage()
        getDirectionsButton.layer.cornerRadius = 10
        addGradient(view: gradientView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleSelectedFavoriteState()
    }
    private func handleSelectedFavoriteState() {
        guard let selectedRecipe = selectedRecipe else { return }
        switch favoriteRecipeDataManager.isRecipeFavorited(recipe: selectedRecipe) {
        case .failure(let error):
            presentAlert(title: "Error", message: error.localizedDescription)
        case .success(let isFavorited):
            isPresentedRecipeFavorited = isFavorited
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer?.frame = gradientView.bounds
    }

    
    private var gradientLayer: CAGradientLayer?
    
    private func addGradient(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.darkGray.withAlphaComponent(1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = gradientView.bounds
        
        gradient.locations = [0.2, 1]
        view.layer.addSublayer(gradient)
        self.gradientLayer = gradient
        
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
    
    private func saveSelectedRecipe(_ selectedRecipe: Recipe) {
        switch favoriteRecipeDataManager.save(recipeToSave: selectedRecipe) {
        case .failure(let error):
            presentAlert(title: "Error", message: error.localizedDescription)
        case .success: break
        }
        
        handleSelectedFavoriteState()
    }
    
    private func deleteSelectedRecipe(_ selectedRecipe: Recipe) {
        switch favoriteRecipeDataManager.deleteRecipe(recipe: selectedRecipe) {
        case .failure(let error):
            presentAlert(title: "Error", message: error.localizedDescription)
        case .success: break
        }
        
        handleSelectedFavoriteState()
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
