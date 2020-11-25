//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Nathan on 20/11/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import CoreData


enum CoreDataManagerError: Error {
    case failedToFetchElements
    case failedToRemoveElements
    case failedToSaveElements
}


class CoreDataManager {
    init(contextProvider: ContextProvider = ServiceContainer.contextProvider) {
        self.contextProvider = contextProvider
    }
    
    let contextProvider: ContextProvider
    
    
    
    
    
    func getAllElements<T: NSFetchRequestResult>(resultType: T.Type) -> Result<[T], CoreDataManagerError>  {
        let request = NSFetchRequest<T>(entityName: "\(T.self)")
        

        let fetchResult = contextProvider.fetch(request: request)
        
        switch fetchResult {
        case .failure:
            return .failure(.failedToFetchElements)
        case .success(let elements):
            return .success(elements)
        }
    }
    
    
    
    func removeAllElements<T: NSManagedObject>(resultType: T.Type) -> Result<Void, CoreDataManagerError> {
        let elementsToDeleteResult = getAllElements(resultType: resultType)
        
        switch elementsToDeleteResult {
        case .failure:
            return .failure(.failedToRemoveElements)
        case .success(let elementsToDelete):
            for element in elementsToDelete {
                contextProvider.delete(object: element)
            }
            
            return save()
        }
    }
    
    func save() -> Result<Void, CoreDataManagerError> {
        let saveResult = contextProvider.save()
        
        switch saveResult {
        case .failure:
            return .failure(.failedToSaveElements)
        case .success:
            return .success(())
        }
    }
    
    
    func getObject<T: NSManagedObject>(objectType: T.Type) -> T {
        NSEntityDescription.insertNewObject(forEntityName: "\(T.self)", into: contextProvider.context) as! T
    }
    
    
}
