//
//  FridgeServiceErrorTests.swift
//  RecipleaseTests
//
//  Created by Nathan on 16/08/2021.
//  Copyright © 2021 NathanChicha. All rights reserved.
//

import XCTest
@testable import Reciplease

class FridgeServiceErrorTests: XCTestCase {

    func testfailedAddIngredientIngredientIsEmpty() {
        let fridgeServiceError: FridgeServiceError = .failedAddIngredientIngredientIsEmpty
        
        XCTAssertEqual(fridgeServiceError.message, "Vous devez ajouter un ingrédient")
    }
    func testfailedToAddIngredientAlreadyAdded() {
        let fridgeServiceError: FridgeServiceError = .failedToAddIngredientAlreadyAdded
        
        XCTAssertEqual(fridgeServiceError.message, "Vous avez deja rajouter cet ingredient")
    }
    func testfailedToAddIngredientIngredientContainsSpecialCharacter() {
        let fridgeServiceError: FridgeServiceError = .failedToAddIngredientIngredientContainsSpecialCharacter
        
        XCTAssertEqual(fridgeServiceError.message, "Votre ingredient contient des caracteres special")
    }
    func testfailedToSearchRecipes() {
        let fridgeServiceError: FridgeServiceError = .failedToSearchRecipes
        XCTAssertEqual(fridgeServiceError.message, "Impossible de rechercher des recettes")
    }

}
