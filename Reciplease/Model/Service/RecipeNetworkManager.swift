//
//  RecipeNetworkManager.swift
//  Reciplease
//
//  Created by Nathan on 22/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation


class RecipeNetworkManager {
    
    init(networkManager: NetworkManagerProtocol = AlamofireNetworkManager(),
         recipeUrlProvider: RecipeUrlProvider = RecipeUrlProvider()) {
        self.networkManager = networkManager
        self.recipeUrlProvider = recipeUrlProvider
    }
    
    private let networkManager: NetworkManagerProtocol
    private let recipeUrlProvider: RecipeUrlProvider
    func fetchRecipe(ingredients: [String], completionHandler: @escaping (Result<RecipeResult, NetworkManagerError>) -> Void) {
        
        guard let url = recipeUrlProvider.createUrl(ingredients: ingredients) else {
            completionHandler(.failure(.unknownErrorOccured))
            return
        }
        
        networkManager.fetchResult(url: url, completionHandler: completionHandler)
    }
    

    
 
}
