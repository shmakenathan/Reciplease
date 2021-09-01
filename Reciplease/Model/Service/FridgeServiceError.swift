
import Foundation


enum FridgeServiceError: Error {
    case failedAddIngredientIngredientIsEmpty
    case failedToAddIngredientAlreadyAdded
    case failedToAddIngredientIngredientContainsSpecialCharacter
    case failedToSearchRecipes
    
    var message: String {
        switch self {
        case .failedAddIngredientIngredientIsEmpty: return Strings.failedAttIngredientEmptyError
        case .failedToAddIngredientAlreadyAdded: return Strings.failedToAddIngredientAlreadyAdded
        case .failedToAddIngredientIngredientContainsSpecialCharacter: return Strings.failedToAddIngredientIngredientContainsSpecialCharacter
        case .failedToSearchRecipes: return Strings.failedToSearchRecipes
        }
    }
}
