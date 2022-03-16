import XCTest
@testable import Reciplease

class FavoriteRecipeDataManagerTestCase: XCTestCase {
    
    func testGivenGetAll() {
        let mock = CoreDataManagerMock()
        let favoriteRecipeDataManager = FavoriteRecipeDataManager(coreDataManager: mock)
        let result = favoriteRecipeDataManager.getAll()
        switch result {
        case .failure:
            XCTFail()
        case .success (let recipes):
            XCTAssertEqual(recipes.count, 1)
        }
        
    }
 
    
}
