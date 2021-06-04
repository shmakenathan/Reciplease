//
//  RecipeNetworkManager.swift
//  Reciplease
//
//  Created by Nathan on 22/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation

enum RecipeNetworkManagerError: Error, LocalizedError {
    case failedToGetRecipes
    case failedToCreateUrl
    
    var errorDescription: String? {
        switch self {
        case .failedToCreateUrl: return "Failed to create url"
        case .failedToGetRecipes: return "Failed to get recipes"
        }
    }
}


protocol RecipeNetworkManagerProtocol {
    func fetchRecipe(
        ingredients: [String],
        completionHandler: @escaping (Result<[Recipe], RecipeNetworkManagerError>) -> Void
    )
}

class RecipeNetworkManagerMock: RecipeNetworkManagerProtocol {
    
    init(result: Result<[Recipe], RecipeNetworkManagerError>) {
        self.result = result
    }
    
    let result: Result<[Recipe], RecipeNetworkManagerError>
    
    func fetchRecipe(ingredients: [String], completionHandler: @escaping (Result<[Recipe], RecipeNetworkManagerError>) -> Void) {
        completionHandler(result)
    }
    
    
}

class RecipeNetworkManager: RecipeNetworkManagerProtocol {
    
    init(networkManager: NetworkManagerProtocol = AlamofireNetworkManager(),
         recipeUrlProvider: RecipeUrlProvider = RecipeUrlProvider()) {
        self.networkManager = networkManager
        self.recipeUrlProvider = recipeUrlProvider
    }
    
    private let networkManager: NetworkManagerProtocol
    private let recipeUrlProvider: RecipeUrlProvider
    func fetchRecipe(
        ingredients: [String],
        completionHandler: @escaping (Result<[Recipe], RecipeNetworkManagerError>) -> Void
    ) {
        
        guard let url = recipeUrlProvider.createUrl(ingredients: ingredients) else {
            completionHandler(.failure(.failedToCreateUrl))
            return
        }
        
        networkManager.fetchResult(url: url) { (result: Result<RecipeSearchResponse, NetworkManagerError>)  in
            switch result {
            case .failure:
                completionHandler(.failure(.failedToGetRecipes))
            case .success(let recipeResponse):
                let recipes = recipeResponse.hits.map { $0.recipe }
                completionHandler(.success(recipes))
            }
            
        }
    }
    

    
 
}
