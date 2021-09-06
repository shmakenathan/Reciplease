//
//  FavoriteRecipeDataManager.swift
//  Reciplease
//
//  Created by Nathan on 20/11/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//



import CoreData

class FavoriteRecipeDataManager {
    
    static let shared = FavoriteRecipeDataManager()
    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
    
    private let coreDataManager: CoreDataManagerProtocol
    
    
    func getAll() -> Result<[RecipeSave], CoreDataManagerError> {
        return coreDataManager.getAllElements(resultType: RecipeSave.self, predicate: nil)
    }

    
    func save(recipeToSave: Recipe) -> Result<Void, CoreDataManagerError> {
        
        let recipeObjectToSave = coreDataManager.getObject(objectType: RecipeSave.self)
    
        recipeObjectToSave.image = recipeToSave.image
        recipeObjectToSave.title = recipeToSave.label
        recipeObjectToSave.ingredient = recipeToSave.ingredientLines
        recipeObjectToSave.time = Int64(recipeToSave.totalTime)
        recipeObjectToSave.url = recipeToSave.url
        recipeObjectToSave.calories = recipeToSave.calories
        recipeObjectToSave.cuisineType = recipeToSave.cuisineType
        return coreDataManager.save()
    }
    
    
    func isRecipeFavorited(recipe: Recipe) -> Result<Bool, CoreDataManagerError> {
        switch getAll() {
        case .success(let savedRecipes):
            let isRecipeFavorited = savedRecipes.contains(where: { (savedRecipe) -> Bool in
                savedRecipe.url == recipe.url
            })
            
            return .success(isRecipeFavorited)
            
        case .failure(let coreDataError):
            return .failure(coreDataError)
        }
    }

    func deleteRecipe(recipe: Recipe) -> Result<Void, CoreDataManagerError> {
        let predicate = NSPredicate(format: "url == %@", recipe.url)
        return coreDataManager.removeAllElements(resultType: RecipeSave.self, predicate: predicate)
    }
    
    func deleteAllRecipes() -> Result<Void, CoreDataManagerError> {
        return coreDataManager.removeAllElements(resultType: RecipeSave.self, predicate: nil)
    }
    
}
