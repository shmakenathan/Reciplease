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
    
//    func testGivenSave() {
//        let mock = CoreDataManagerMock()
//        let favoriteRecipeDataManager = FavoriteRecipeDataManager(coreDataManager: mock)
//
//        let recipeToSave = Recipe(
//            label: "testlabel",
//            image: "image",
//            url: "url",
//            ingredientLines: ["ingredient1test"],
//            totalTime: 100
//        )
//
//        let result = favoriteRecipeDataManager.save(recipeToSave: recipeToSave)
//
//        switch result {
//        case .failure:
//            XCTFail()
//        case .success:
//            XCTAssertEqual(true, true)
//        }
//
//    }
//
    
    
}
