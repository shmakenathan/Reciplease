// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeResult = try? newJSONDecoder().decode(RecipeResult.self, from: jsonData)

import Foundation

// MARK: - RecipeResult
struct RecipeResult: Codable {
    var count: Int
    var hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    var recipe: Recipe
}

// MARK: - Recipe
struct Recipe: Codable {
    var label: String
    var image: String
    var url: String
    var ingredientLines: [String]
    var totalTime: Int
}

