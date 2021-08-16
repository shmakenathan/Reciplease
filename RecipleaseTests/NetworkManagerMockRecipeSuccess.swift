//
//  File.swift
//  RecipleaseTests
//
//  Created by Nathan on 10/12/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation
@testable import Reciplease
class NetworkManagerMockRecipeSuccess: NetworkManagerProtocol {
    func fetchResult<T>(url: URL, completionHandler: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable {
        //completionHandler(.failure(.couldNotDecodeJson))
        
        let recipe = Recipe(
            label: "Omelette",
            image: "",
            url: "",
            ingredientLines: ["Chesse", "eggs"],
            totalTime: 100,
            calories: 40,
            cuisineType: ["French"]
        )
        
        let recipeResult = RecipeSearchResponse(
            count: 4,
            hits: [
                Hit(recipe: recipe)
            ]
        )
        
        
        completionHandler(.success(recipeResult as! T))
    }
    
}
