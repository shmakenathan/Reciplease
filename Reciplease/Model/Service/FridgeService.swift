import Foundation


enum FridgeServiceError: Error {
    case failedAddIngredientIngredientIsEmpty
    case failedToAddIngrdientAlreadyAdded
    
    var message: String {
        switch self {
        case .failedAddIngredientIngredientIsEmpty: return "failedAddIngredientIngredientIsEmpty"
        case .failedToAddIngrdientAlreadyAdded: return "failedToAddIngrdientAlreadyAdded"
        }
    }
}

protocol FridgeServiceDelegate: class {
    func didUpdateIngredients()
}

class FridgeService {
    weak var delegate: FridgeServiceDelegate?
    
    var ingredients: [String] = [] {
        didSet {
            delegate?.didUpdateIngredients()
        }
    }
    
    func checkIfOnlyWhitespace(_ ingredient: String) -> Bool {
        for i in ingredient {
            if i != " " {
                return true
            }
        }
        return false
    }
    func addIngredient(_ ingredient: String) -> Result<Void, FridgeServiceError> {
        
        
        guard !ingredient.isEmpty else {
            return .failure(.failedAddIngredientIngredientIsEmpty)
        }
        guard checkIfOnlyWhitespace(ingredient) else {
            return .failure(.failedAddIngredientIngredientIsEmpty)
        }
        let  newIngredient = ingredient.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !ingredients.contains(newIngredient) else {
            return .failure(.failedToAddIngrdientAlreadyAdded)
        }
        
        ingredients.append(newIngredient)
        return .success(())
    }
    
    func clearIngredients() {
        ingredients.removeAll()
    }
    
    func searchRecipes() {
        
    }
}
