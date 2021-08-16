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

    func testExample() {
        let fridgeServiceError: FridgeServiceError = .failedAddIngredientIngredientIsEmpty
        
        XCTAssertEqual(fridgeServiceError.message, "Aucun ingredient à ajouter, veuillez en rajouter un")
    }


}
