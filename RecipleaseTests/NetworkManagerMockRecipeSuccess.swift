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
        
        let recipeResult = RecipeSearchResponse(count: 4, hits: [Hit(recipe: Recipe(label: "Omelette", image: "", url: "", ingredientLines: ["Chesse", "eggs"], totalTime: 100))])
        completionHandler(.success(recipeResult as! T))
    }
    
}
