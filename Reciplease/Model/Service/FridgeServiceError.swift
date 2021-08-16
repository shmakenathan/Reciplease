
import Foundation


enum FridgeServiceError: Error {
    case failedAddIngredientIngredientIsEmpty
    case failedToAddIngredientAlreadyAdded
    case failedToAddIngredientIngredientContainsSpecialCharacter
    case failedToSearchRecipes
    
    var message: String {
        switch self {
        case .failedAddIngredientIngredientIsEmpty: return Strings.failedAttIngredientEmptyError
        case .failedToAddIngredientAlreadyAdded: return "Ingredient déja ajouté"
        case .failedToAddIngredientIngredientContainsSpecialCharacter: return "Ingredient non reconnu"
        case .failedToSearchRecipes: return "Veuillez réessayer plus tard"
        }
    }
}
