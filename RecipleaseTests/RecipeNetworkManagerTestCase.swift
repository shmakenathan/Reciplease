//
//  RecipeNetworkManagerTestCase.swift
//  RecipleaseTests
//
//  Created by Nathan on 03/12/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipeNetworkManagerTestCase: XCTestCase {
    
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let mock = NetworkManagerMockRecipeSuccess()
        let recipeNetworkNetwokManager = RecipeNetworkManager(networkManager: mock)
        recipeNetworkNetwokManager.fetchRecipe(ingredients: ["cheese"]) { (result) in
            switch result {
            case .failure:
                XCTFail()
            case .success (let recipes):
                XCTAssertEqual("Omelette", recipes.first!.label)
            }
        }
    }
    
    func testWhenCouldNotDecodeJson() {
        let mock = NetworkManagerMockRecipeNoSuccessCouldNotDecodeJson()
        let recipeNetworkNetwokManager = RecipeNetworkManager(networkManager: mock)
        recipeNetworkNetwokManager.fetchRecipe(ingredients: ["cheese"]) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.errorDescription, "Failed to get recipes")
               
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
                XCTAssertEqual(error, RecipeNetworkManagerError.failedToCreateUrl)
                XCTAssertEqual(error.errorDescription, "Failed to create url")
            case .success:
                XCTFail()
            }
        }
    }
    
    
    func test_givenNetworkManagerWithSuccessSession_whenFetchResult_thenSuccess() {
 
        let mock = AlamofireSessionSuccessMock()
        
        let alamofireNetworManager = AlamofireNetworkManager(alamofireSession: mock)
        
        let testUrl = URL(string: "www.google.com")!
                                                             
        alamofireNetworManager.fetchResult(url: testUrl) { (result: Result<RecipeSearchResponse, NetworkManagerError>) in
            switch result {
            case .failure:
                XCTFail()
            case .success(let response):
                XCTAssertEqual(response.count, 3)
            }
        }
                                                            
    }
    
    
    func test_asddsa() {
 
        let mock = AlamofireSessionFailureMock()
        
        let alamofireNetworManager = AlamofireNetworkManager(alamofireSession: mock)
        
        let testUrl = URL(string: "www.google.com")!
                                                             
        alamofireNetworManager.fetchResult(url: testUrl) { (result: Result<RecipeSearchResponse, NetworkManagerError>) in
            switch result {
            case .failure:
                XCTAssertTrue(true)
                
            case .success:
                XCTFail()
            }
        }
                                                            
    }
}
