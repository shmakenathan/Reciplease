import Foundation
import CoreData
@testable import Reciplease



class CoreDataManagerMock: CoreDataManagerProtocol {
    func getAllElements<T>(resultType: T.Type, predicate: NSPredicate?) -> Result<[T], CoreDataManagerError> where T : NSFetchRequestResult {
        
        let recipeTest = RecipeSave()
        
//        recipeTest.title = "Omellette"
//        recipeTest.ingredient = ["Jambon", "fromage", "Oeuf"]
        
        
        let recipes = [
            recipeTest
        ] as! [T]
        
        return .success(recipes)
    }
    
    func removeAllElements<T>(resultType: T.Type, predicate: NSPredicate?) -> Result<Void, CoreDataManagerError> where T : NSManagedObject {
        return .success(())
    }
    
    func save() -> Result<Void, CoreDataManagerError> {
        return .success(())
    }
    
    func getObject<T>(objectType: T.Type) -> T where T : NSManagedObject {
        let recipeTest = RecipeSave()
        
//        recipeTest.title = "Omellette"
//        recipeTest.ingredient = ["Jambon", "fromage", "Oeuf"]
        
        return recipeTest as! T
    }
    
    
}
