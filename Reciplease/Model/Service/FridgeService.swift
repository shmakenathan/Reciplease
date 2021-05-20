import Foundation


enum FridgeServiceError: Error {
    case failedAddIngredientIngredientIsEmpty
    case failedToAddIngredientAlreadyAdded
    case failedToAddIngredientIngredientContainsSpecialCharacter
    case failedToSearchRecipes
    
    var message: String {
        switch self {
        case .failedAddIngredientIngredientIsEmpty: return "failedAddIngredientIngredientIsEmpty"
        case .failedToAddIngredientAlreadyAdded: return "failedToAddIngrdientAlreadyAdded"
        case .failedToAddIngredientIngredientContainsSpecialCharacter: return "failedToAddIngredientIngredientContainsSpecialCharacter"
        case .failedToSearchRecipes: return "failedToSearchRecipes"
        }
    }
}

protocol FridgeServiceDelegate: class {
    func didUpdateIngredients()
}

class FridgeService {
    weak var delegate: FridgeServiceDelegate?
    var recipeNetworkManager =  RecipeNetworkManager()
    var ingredients: [String] = [] {
        didSet {
            delegate?.didUpdateIngredients()
        }
    }
    
    
    
    
    func addIngredient(_ ingredient: String) -> Result<Void, FridgeServiceError> {
        
        let trimmedIngredient = ingredient.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        guard !trimmedIngredient.isEmpty else {
            return .failure(.failedAddIngredientIngredientIsEmpty)
        }
        
        guard !ingredients.contains(trimmedIngredient) else {
            return .failure(.failedToAddIngredientAlreadyAdded)
        }
        
        guard getIsOnlyValidCharacterUsed(in: trimmedIngredient) else {
            return .failure(.failedToAddIngredientIngredientContainsSpecialCharacter)
        }
        
        ingredients.append(trimmedIngredient)
        
        return .success(())
    }
    
    func clearIngredients() {
        ingredients.removeAll()
    }
    
    func searchRecipes(completionHandler: @escaping (Result<[Recipe], FridgeServiceError>) -> Void) {
   
        recipeNetworkManager.fetchRecipe(
            ingredients: ingredients,
            completionHandler: { result in
                switch result {
                case .failure:
                    completionHandler(.failure(.failedToSearchRecipes))
                case .success(let recipes):
                    completionHandler(.success(recipes))
                }
                
            }
        )
    }
    
    private func getIsOnlyValidCharacterUsed(in ingredient: String) -> Bool {
        let commonCharacterRegex = #"^[a-zA-Z0-9äöüÄÖÜ]*$"#
        
        let result = ingredient.range(
            of: commonCharacterRegex,
            options: .regularExpression
        )
        
        let validIngredient = result != nil
        
        return validIngredient
    }
}
