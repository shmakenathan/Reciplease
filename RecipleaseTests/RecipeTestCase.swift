//
//  RecipeTestCase.swift
//  RecipleaseTests
//
//  Created by Nathan on 03/12/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeTestCase: XCTestCase {
    
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let mock = NetworkManagerMockRecipeSuccess()
        let recipeNetworkNetwokManager = RecipeNetworkManager(networkManager: mock)
        recipeNetworkNetwokManager.fetchRecipe(ingredients: ["cheese"]) { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success (let result):
                XCTAssertEqual("Omelette", result.hits[0].recipe.label)
            }
        }
    }
    
    func testWhenCouldNotDecodeJson() {
        let mock = NetworkManagerMockRecipeNoSuccessCouldNotDecodeJson()
        let recipeNetworkNetwokManager = RecipeNetworkManager(networkManager: mock)
        recipeNetworkNetwokManager.fetchRecipe(ingredients: ["cheese"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, "Unable to decode JSON file")
               
            case .success:
                XCTFail()
            }
        }
    }
    
    func testWhenInvalideResponse() {
        let mock = NetworkManagerMockRecipeNoSuccessInvalideResponse()
        let recipeNetworkNetwokManager = RecipeNetworkManager(networkManager: mock)
        recipeNetworkNetwokManager.fetchRecipe(ingredients: ["cheese"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, "Invalid Response Status Code")
               
            case .success:
                XCTFail()
            }
        }
    }
    func testWhenNoData() {
        let mock = NetworkManagerMockRecipeNoSuccessNoDataReceive()
        let recipeNetworkNetwokManager = RecipeNetworkManager(networkManager: mock)
        recipeNetworkNetwokManager.fetchRecipe(ingredients: ["cheese"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message,  "No data received")
               
            case .success:
                XCTFail()
            }
        }
    }
    
    func testGetRecipeWithNoUrl() {
        
    
        let recipeUrlProvider = RecipeUrlProviderMock()
        let mock = NetworkManagerMockRecipeSuccess()
        let recipeNetworkNetwokManager = RecipeNetworkManager(networkManager: mock, recipeUrlProvider: recipeUrlProvider)
        recipeNetworkNetwokManager.fetchRecipe(ingredients: ["cheese"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkManagerError.unknownErrorOccured)
            case .success:
                XCTFail()
            }
        }
    }
}
