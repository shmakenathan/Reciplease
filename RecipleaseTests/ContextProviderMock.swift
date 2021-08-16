//
//  ContextProviderMock.swift
//  RecipleaseTests
//
//  Created by Nathan on 02/08/2021.
//  Copyright © 2021 NathanChicha. All rights reserved.
//

import Foundation
import CoreData
@testable import Reciplease



class ContextProviderMock: ContextProviderProtocol {
    let context: NSManagedObjectContext = ContextProvider.getContext(shouldBeInMemory: true)
    
    func fetch<T>(request: NSFetchRequest<T>) -> Result<[T], CoreDataManagerError> where T : NSFetchRequestResult {
        return .failure(.failedToFetchElements)
    }
    
    func save() -> Result<Void, CoreDataManagerError> {
        return .failure(.failedToSaveElements)
    }
    
    func delete(object: NSManagedObject) {
    }
    
}
