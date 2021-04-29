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
    func test_givenAlreadyAddedIngredient_whenAddIngredient_thenGetAlreadyAddedFailure() {
        let fridgeService = FridgeService()
        _ = fridgeService.addIngredient("Cheese")
        switch fridgeService.addIngredient("Cheese") {
        
        case .failure(let error): XCTAssertEqual(error, .failedToAddIngrdientAlreadyAdded)
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
}
