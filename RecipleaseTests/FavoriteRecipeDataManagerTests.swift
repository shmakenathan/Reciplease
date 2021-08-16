import Foundation


import XCTest
@testable import Reciplease

class FavoriteRecipeDataManagerTests: XCTestCase {
    
    var favoriteRecipeDataManager: FavoriteRecipeDataManager!
    
    
    override func setUp() {
        super.setUp()
        favoriteRecipeDataManager = FavoriteRecipeDataManager()
        _ = favoriteRecipeDataManager.deleteAllRecipes()
    }
    
    
    func test_givenNotYetStoredRecipe_whenSavingRecipe_thenRecipeIsAddedToStoredRecipes() {
        
        let recipe = Recipe(
            label: "Pizza",
            image: "",
            url: "www.myrecipes.com/pizza",
            ingredientLines: [],
            totalTime: 3,
            calories: 40,
            cuisineType: []
        )
        
       
        
        switch favoriteRecipeDataManager.getAll() {
        case .failure:
            XCTFail()
        case .success(let initialStoredRecipes):
            XCTAssertEqual(initialStoredRecipes.count, 0)
        }
    
        
        switch favoriteRecipeDataManager.save(recipeToSave: recipe) {
        case .failure:
            XCTFail()
        case .success:
           
            
            switch favoriteRecipeDataManager.getAll() {
            case .failure:
                XCTFail()
            case .success(let initialStoredRecipes):
                XCTAssertEqual(initialStoredRecipes.count, 1)
                XCTAssertEqual(initialStoredRecipes.first!.title, "Pizza")
            }
            

            
        }
        

        
        
    }
    


    func test_givenOneStoredRecipe_whenDeletingRecipe_thenGetEmptyRecipes() {

        let recipe = Recipe(
            label: "Pizza",
            image: "",
            url: "www.myrecipes.com/pizza",
            ingredientLines: [],
            totalTime: 3,
            calories: 40,
            cuisineType: []
        )
        
        _ = favoriteRecipeDataManager.save(recipeToSave: recipe)


        switch favoriteRecipeDataManager.getAll() {
        case .failure:
            XCTFail()
        case .success(let initialStoredRecipes):
            XCTAssertEqual(initialStoredRecipes.count, 1)
        }
        
        _ = favoriteRecipeDataManager.deleteRecipe(recipe: recipe)


        switch favoriteRecipeDataManager.getAll() {
        case .failure:
            XCTFail()
        case .success(let initialStoredRecipes):
            XCTAssertEqual(initialStoredRecipes.count, 0)
        }
    


    }
    
    
    
    func test_givenOneStoredRecipe_whenCheckingIfRecipeIsFavorite_thenGetTrue() {


        let recipe = Recipe(
            label: "Pizza",
            image: "",
            url: "www.myrecipes.com/pizza",
            ingredientLines: [],
            totalTime: 3,
            calories: 40,
            cuisineType: []
        )
        
        
        
        _ = favoriteRecipeDataManager.save(recipeToSave: recipe)


        switch favoriteRecipeDataManager.getAll() {
        case .failure:
            XCTFail()
        case .success(let initialStoredRecipes):
            XCTAssertEqual(initialStoredRecipes.count, 1)
        }
        


        switch favoriteRecipeDataManager.isRecipeFavorited(recipe: recipe) {
        case .failure:
            XCTFail()
        case .success(let isFavorited):
            XCTAssertTrue(isFavorited)
        }
    


    }
    
    
    func test_givenNoStoredRecipe_whenCheckingIfRecipeIsFavorite_thenGetFalse() {


        let recipe = Recipe(
            label: "Pizza",
            image: "",
            url: "www.myrecipes.com/pizza",
            ingredientLines: [],
            totalTime: 3,
            calories: 40,
            cuisineType: []
        )
        



        switch favoriteRecipeDataManager.getAll() {
        case .failure:
            XCTFail()
        case .success(let initialStoredRecipes):
            XCTAssertEqual(initialStoredRecipes.count, 0)
        }
        


        switch favoriteRecipeDataManager.isRecipeFavorited(recipe: recipe) {
        case .failure:
            XCTFail()
        case .success(let isFavorited):
            XCTAssertFalse(isFavorited)
        }
    


    }
    
    
    func test_givenNoStoredRecipe_whenCheckingIfRecipeIsFavorite_thenGetCoreDataError() {
        let coreDataManagerFailureMock = CoreDataManagerFailureMock()
        favoriteRecipeDataManager = FavoriteRecipeDataManager(coreDataManager: coreDataManagerFailureMock)

        let recipe = Recipe(
            label: "Pizza",
            image: "",
            url: "www.myrecipes.com/pizza",
            ingredientLines: [],
            totalTime: 3,
            calories: 40,
            cuisineType: []
        )


        switch favoriteRecipeDataManager.isRecipeFavorited(recipe: recipe) {
        case .failure:
            XCTAssertTrue(true)
        case .success:
            XCTFail()
        }


    }
    

}
