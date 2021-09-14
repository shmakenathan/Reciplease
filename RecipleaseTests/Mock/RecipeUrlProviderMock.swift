//
//  RecipeUrlProviderMock.swift
//  RecipleaseTests
//
//  Created by Nathan on 10/12/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//
import Foundation
@testable import Reciplease

class RecipeUrlProviderMock: RecipeUrlProvider {
    override func createUrl(ingredients: [String]) -> URL? {
        return nil
    }
}
