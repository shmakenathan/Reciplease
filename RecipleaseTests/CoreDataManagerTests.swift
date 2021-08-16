//
//  CoreDataManagerTestss.swift
//  RecipleaseTests
//
//  Created by Nathan on 02/08/2021.
//  Copyright © 2021 NathanChicha. All rights reserved.
//

import XCTest
@testable import Reciplease

class CoreDataManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let coreDataManager = CoreDataManager()
        
        _ =  coreDataManager.removeAllElements(resultType: RecipeSave.self, predicate: nil)
    }
    
    func test_givenFailureContextProviderFetch_whenGetAllElements_thenGetFailedToFetchElementsError() {
        let contextProviderMock = ContextProviderMock()
        let coreDataManager = CoreDataManager(contextProvider: contextProviderMock)
        
        
        switch coreDataManager.getAllElements(resultType: RecipeSave.self, predicate: nil) {
        case .failure(let error):
            XCTAssertEqual(error, .failedToFetchElements)
        case .success:
            XCTFail()
        }
    }
    
    
    
    func test_givenFailureContextProviderFetch_whenRemoveAllElements_thenGetFailedToRemoveElementsError() {
        let contextProviderMock = ContextProviderMock()
        let coreDataManager = CoreDataManager(contextProvider: contextProviderMock)
        
        
        switch coreDataManager.removeAllElements(resultType: RecipeSave.self, predicate: nil) {
        case .failure(let error):
            XCTAssertEqual(error, .failedToRemoveElements)
        case .success:
            XCTFail()
        }
    }


    
    func test_givenFailureContextProviderSave_whenSaving_thenGetFailedToSaveElementsError() {
        let contextProviderMock = ContextProviderMock()
        let coreDataManager = CoreDataManager(contextProvider: contextProviderMock)
        
        
        switch coreDataManager.save() {
        case .failure(let error):
            XCTAssertEqual(error, .failedToSaveElements)
        case .success:
            XCTFail()
        }
    }
    
    
    
    func test_asd() {
        let coreDataManager = CoreDataManager()
        
        
        switch coreDataManager.getAllElements(resultType: RecipeSave.self, predicate: nil) {
        case .failure:
            XCTFail()
            
        case .success(let savedRecipes):
            XCTAssertEqual(savedRecipes.count, 0)

        }
    }


}
