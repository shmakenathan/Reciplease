//
//  FavoriteRecipeDataManager.swift
//  Reciplease
//
//  Created by Nathan on 20/11/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

class ServiceContainer {
    static let contextProvider = ContextProvider()
    static let coreDataManager = CoreDataManager()
    static let favoriteRecipeDataManager = FavoriteRecipeDataManager()
}

import CoreData

class FavoriteRecipeDataManager {
    
    init(coreDataManager: CoreDataManager = ServiceContainer.coreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    private let coreDataManager: CoreDataManager
    
    
    func getAll() -> Result<[RecipeSave], CoreDataManagerError> {
        return coreDataManager.getAllElements(resultType: RecipeSave.self)
    }
    
    func save(recipeToSave: Recipe) -> Result<Void, CoreDataManagerError> {
        
        let recipeObjectToSave = coreDataManager.getObject(objectType: RecipeSave.self)
        
        
        recipeObjectToSave.image = recipeToSave.image
        recipeObjectToSave.title = recipeToSave.label
        recipeObjectToSave.ingredient = recipeToSave.ingredientLines
        recipeObjectToSave.time = Int64(recipeToSave.totalTime)
        recipeObjectToSave.url = recipeToSave.url
        
        return coreDataManager.save()
    }
    
    
}
