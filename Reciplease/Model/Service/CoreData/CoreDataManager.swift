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
    init(contextProvider: ContextProvider = ContextProvider()) {
        self.contextProvider = contextProvider
    }
    
    let contextProvider: ContextProvider
    
    
    
    
    
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
    
//    func deleteFavoriteRecipe(withUrl url: String) throws {
//        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
//        request.predicate = NSPredicate(format: "url == %@", url)
//
//        var favoriteRecipesToRemove: [FavoriteRecipe]
//
//        do {
//            favoriteRecipesToRemove = try coreDataManager.contextProvider.fetch(request)
//        } catch {
//            throw error
//        }
//
//        favoriteRecipesToRemove.forEach {
//            coreDataManager.contextProvider.delete($0)
//        }
//        do {
//            try coreDataManager.save()
//        } catch {
//            throw error
//        }
//    }
//
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
