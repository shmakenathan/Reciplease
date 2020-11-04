// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeResult = try? newJSONDecoder().decode(RecipeResult.self, from: jsonData)

import Foundation

// MARK: - RecipeResult
struct RecipeResult: Codable {
    let count: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
    let ingredients: [Ingredient]
    let totalTime: Int
}


// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let weight: Double
    let image: String?
}
