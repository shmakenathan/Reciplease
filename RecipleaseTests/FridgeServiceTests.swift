//
//  FridgeServiceTests.swift
//  RecipleaseTests
//
//  Created by Nathan on 29/04/2021.
//  Copyright © 2021 NathanChicha. All rights reserved.
//

import XCTest
@testable import Reciplease
class FridgeServiceTests: XCTestCase {

    func test_givenEmptyIngredient_whenAddIngredient_thenGetEmptyFailure() {
        let fridgeService = FridgeService()
        switch fridgeService.addIngredient("") {
        
        case .failure(let error): XCTAssertEqual(error, .failedAddIngredientIngredientIsEmpty)
        case .success(_): XCTFail()
        }
    }

    
    func test_givenOnlyWhitespace_whenAddIngredient_thenGetEmptyFailure() {
        let fridgeService = FridgeService()
        switch fridgeService.addIngredient("     "){
        case .failure(let error): XCTAssertEqual(error, .failedAddIngredientIngredientIsEmpty)
        case .success(_): XCTFail()
        }
    }
    
    
    
    func test_givenAlreadyAddedIngredient_whenAddIngredient_thenGetAlreadyAddedFailure() {
        let fridgeService = FridgeService()
        _ = fridgeService.addIngredient("Cheese")
        switch fridgeService.addIngredient("Cheese") {
        
        case .failure(let error): XCTAssertEqual(error, .failedToAddIngredientAlreadyAdded)
        case .success(_): XCTFail()
        }
    }
    
    
    func test_givenAlreadyAddedIngredientNotCapitalized_whenAddIngredientWithSameCasing_thenGetAlreadyAddedFailure() {
        let fridgeService = FridgeService()
        _ = fridgeService.addIngredient("cheese")
        switch fridgeService.addIngredient("cheese") {
        
        case .failure(let error): XCTAssertEqual(error, .failedToAddIngredientAlreadyAdded)
        case .success(_): XCTFail()
        }
    }
    
    
    func test_givenAlreadyAddedIngredientWithDifferentCasing_whenAddIngredient_thenGetAlreadyAddedFailure() {
        let fridgeService = FridgeService()
        _ = fridgeService.addIngredient("cheEse")
        switch fridgeService.addIngredient("Cheese") {
        
        case .failure(let error): XCTAssertEqual(error, .failedToAddIngredientAlreadyAdded)
        case .success(_): XCTFail()
        }
    }
    
    func test_givenEmptyIngredientsList_whenAddIngredient_thenIngredientIsAdded() {
        let fridgeService = FridgeService()
        XCTAssertEqual(fridgeService.ingredients.count, 0)
        switch fridgeService.addIngredient("Cheese") {
        
        case .failure(_): XCTFail()
        case .success(_): XCTAssertEqual(fridgeService.ingredients.count, 1)
        }
    }
    
    func test_givenNotEmptyIngredientsList_whenClearIngredientsList_thenIngredientsListIsEmpty() {
        let fridgeService = FridgeService()
        _ = fridgeService.addIngredient("Cheese")
        fridgeService.clearIngredients()
        XCTAssertEqual(fridgeService.ingredients.count, 0)
        
    }
    
    
    func test_givenStartingWithWhitespaceIngredient_whenAddIngredient_thenIngredientIsAdded() {
        let fridgeService = FridgeService()
        XCTAssertEqual(fridgeService.ingredients.count, 0)
        switch fridgeService.addIngredient("   Cheese") {
        
        case .failure(_): XCTFail()
        case .success(_): XCTAssertEqual(fridgeService.ingredients.first!, "cheese")
        }
    }
    
    func test_givenEndingWithWhitespaceIngredient_whenAddIngredient_thenIngredientIsAdded() {
        let fridgeService = FridgeService()
        XCTAssertEqual(fridgeService.ingredients.count, 0)
        switch fridgeService.addIngredient("Cheese    ") {
        
        case .failure(_): XCTFail()
        case .success(_): XCTAssertEqual(fridgeService.ingredients.first!, "cheese")
        }
    }
    
    func test_givenStartAndEndWithWhitespaceIngredient_whenAddIngredient_thenIngredientIsAdded() {
        let fridgeService = FridgeService()
        XCTAssertEqual(fridgeService.ingredients.count, 0)
        switch fridgeService.addIngredient("    Cheese    ") {
        
        case .failure(_): XCTFail()
        case .success(_): XCTAssertEqual(fridgeService.ingredients.first!, "cheese")
        }
    }
    
    
    
    func test_givenNonCapitalizedIngredient_whenAddIngredient_thenIngredientIsAddedCapitalized() {
        let fridgeService = FridgeService()
        XCTAssertEqual(fridgeService.ingredients.count, 0)
        switch fridgeService.addIngredient("cheese") {
        
        case .failure(_): XCTFail()
        case .success(_): XCTAssertEqual(fridgeService.ingredients.first!, "cheese")
        }
    }
    
    func test_givenSpecialCasingIngredient_whenAddIngredient_thenIngredientIsAddedCapitalized() {
        let fridgeService = FridgeService()
        XCTAssertEqual(fridgeService.ingredients.count, 0)
        switch fridgeService.addIngredient("chEese") {
        
        case .failure(_): XCTFail()
        case .success(_): XCTAssertEqual(fridgeService.ingredients.first!, "cheese")
        }
    }
    
    
    func test_givenIngredientWithSpecialCharacter_whenAddIngredient_thenGetIngredientContainsSpecialCharacterFailure() {
        let fridgeService = FridgeService()
        switch fridgeService.addIngredient("ch§eese!") {
        
        case .failure(let error): XCTAssertEqual(error, .failedToAddIngredientIngredientContainsSpecialCharacter)
        case .success(_): XCTFail()
        }
    }
    

   
}
