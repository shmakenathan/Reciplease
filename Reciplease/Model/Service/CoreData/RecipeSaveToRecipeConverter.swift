//
//  RecipeSaveToRecipe.swift
//  Reciplease
//
//  Created by Nathan on 26/11/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation
import CoreData

class RecipeSaveToRecipeConverter {
    
    func convert(recipeSave: RecipeSave) -> Recipe? {
        
        guard let image = recipeSave.image,
              let url = recipeSave.url,
              let title = recipeSave.title,
              let ingredient = recipeSave.ingredient
        
        else {
            return nil
        }
        
        
        let recipe = Recipe(label: title,
                            image: image,
                            url : url,
                            ingredientLines: ingredient,
                            totalTime:  Int(recipeSave.time),
                            calories: recipeSave.calories,
                            cuisineType: recipeSave.cuisineType)
        
        
        return recipe
    }
    
    
}
