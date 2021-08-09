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


protocol CoreDataManagerProtocol {
    func getAllElements<T: NSFetchRequestResult>(resultType: T.Type, predicate: NSPredicate?) -> Result<[T], CoreDataManagerError>
    
    func removeAllElements<T: NSManagedObject>(resultType: T.Type, predicate: NSPredicate?) -> Result<Void, CoreDataManagerError>
    
    func save() -> Result<Void, CoreDataManagerError>
    
    func getObject<T: NSManagedObject>(objectType: T.Type) -> T
}




class CoreDataManager: CoreDataManagerProtocol {
    init(contextProvider: ContextProviderProtocol = ContextProvider()) {
        self.contextProvider = contextProvider
    }
    

    
    
    
    
    
    func getAllElements<T: NSFetchRequestResult>(resultType: T.Type, predicate: NSPredicate?) -> Result<[T], CoreDataManagerError>  {
        let request = NSFetchRequest<T>(entityName: "\(T.self)")
        request.predicate = predicate
        

        let fetchResult = contextProvider.fetch(request: request)
        
        switch fetchResult {
        case .failure:
            return .failure(.failedToFetchElements)
        case .success(let elements):
            return .success(elements)
        }
    }
    
    
    
    func removeAllElements<T: NSManagedObject>(resultType: T.Type, predicate: NSPredicate?) -> Result<Void, CoreDataManagerError> {
        let elementsToDeleteResult = getAllElements(resultType: resultType, predicate: predicate)
        
        
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
      T.init(context: contextProvider.context)
//      NSEntityDescription.insertNewObject(forEntityName: "\(T.self)", into: contextProvider.context) as! T
    }

    
    
    
    
    
    private let contextProvider: ContextProviderProtocol
    
    
}
