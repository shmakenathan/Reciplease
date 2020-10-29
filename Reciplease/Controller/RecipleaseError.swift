//
//  RecipleaseError.swift
//  Reciplease
//
//  Created by Nathan on 28/10/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import Foundation

enum RecipleaseError: Error {
    case ingredientAlreadyPresent
    case noResults
    case noIngredient
    
    var message: String {
        switch self {
        case .ingredientAlreadyPresent: return "Ingredient already present in the list"
        case .noResults: return "Ooops, no existing recipes for desired foods. Please try again."
        case .noIngredient: return "Please, add Ingredient"
        }
    }
}
