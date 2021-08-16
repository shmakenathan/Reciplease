//
//  ConvertRecipeSaveToRecipeTest.swift
//  RecipleaseTests
//
//  Created by Nathan on 10/08/2021.
//  Copyright © 2021 NathanChicha. All rights reserved.
//

import XCTest
import Foundation
@testable import Reciplease

class ConvertRecipeSaveToRecipeTest: XCTestCase {

    
    func testGetRecipeSaveAndCorrectData() {
        let contexte = ContextProviderMock().context
        let recipe = RecipeSave(context: contexte)
        
        recipe.calories = 20
        recipe.image = "www.myimage.com/id0111"
        recipe.url = "www.mzrecipe.com/id0123"
        recipe.ingredient = []
        recipe.title = "Pizza"
        
        
        let recipeSaveToRecipeConverter = RecipeSaveToRecipeConverter()
        
        let recipeConverted = recipeSaveToRecipeConverter.convert(recipeSave: recipe)
        
        XCTAssertEqual(recipe.calories, recipeConverted!.calories)
    }
    
    
    func test_givenRecipeSaveToConvertWithMissingField_whenConvert_thenGetNil() {
        let contexte = ContextProviderMock().context
        let recipe = RecipeSave(context: contexte)
        
        recipe.calories = 20
        
        recipe.url = "www.mzrecipe.com/id0123"
        recipe.ingredient = []
        recipe.title = "Pizza"
        
        
        let recipeSaveToRecipeConverter = RecipeSaveToRecipeConverter()
        
        let recipeConverted = recipeSaveToRecipeConverter.convert(recipeSave: recipe)
        
        XCTAssertNil(recipeConverted)
    }
}
