//
//  ContextProvider.swift
//  Reciplease
//
//  Created by Nathan on 20/11/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import CoreData

protocol ContextProviderProtocol {
    var context: NSManagedObjectContext { get }
    
    func fetch<T: NSFetchRequestResult>(request: NSFetchRequest<T>) -> Result<[T], CoreDataManagerError>
    func save() -> Result<Void, CoreDataManagerError>
    func delete(object: NSManagedObject)
}




class ContextProvider: ContextProviderProtocol {
    
    
    lazy var context: NSManagedObjectContext = {
        let container: NSPersistentContainer = NSPersistentContainer(name: "Reciplease")
        container.loadPersistentStores { _, _ in }
        return container.viewContext
    }()
    
    
    
    func fetch<T: NSFetchRequestResult>(request: NSFetchRequest<T>) -> Result<[T], CoreDataManagerError> {
        guard let elements = try? context.fetch(request) else {
            return .failure(.failedToFetchElements)
        }
        
        return .success(elements)
    }
    
    func save() -> Result<Void, CoreDataManagerError> {
        do {
            try context.save()
            return .success(())
        } catch {
            return .failure(.failedToSaveElements)
        }
    }
    
    
    func delete(object: NSManagedObject) {
        context.delete(object)
    }
}
