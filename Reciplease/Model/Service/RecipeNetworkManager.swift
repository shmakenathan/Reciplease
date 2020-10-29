//
//  RecipeNetworkManager.swift
//  Reciplease
//
//  Created by Nathan on 22/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation
class RecipeNetworkManager {
    
    var networkManager = NetworkManager()
    
    func fetchRecipe(ingredients: [String], completionHandler: @escaping (Result<RecipeResult, NetworkManagerError>) -> Void) {
        
        guard let url = createUrl(ingredients: ingredients) else {
            completionHandler(.failure(.unknownErrorOccured))
            return
        }
        
        networkManager.fetchResult(url: url, completionHandler: completionHandler)
    }
    
    private func createUrl(ingredients: [String]) -> URL? {
        
        let ingredientsValue = ingredients.reduce("") { $0 + $1 + " " }
        
        let key = "1f08d1ae3fc0ae814670941699ecfbcc"
        let id = "db2d749e"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: ingredientsValue),
            URLQueryItem(name: "app_id", value: id),
            URLQueryItem(name: "app_key", value: key)
        ]
        return urlComponents.url
    }
}
