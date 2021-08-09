import Foundation

protocol FridgeServiceDelegate: AnyObject {
    func didUpdateIngredients()
}

class FridgeService {
    
    init(recipeNetworkManager: RecipeNetworkManagerProtocol = RecipeNetworkManager()) {
        self.recipeNetworkManager = recipeNetworkManager
    }
    
    weak var delegate: FridgeServiceDelegate?
    let recipeNetworkManager: RecipeNetworkManagerProtocol
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
