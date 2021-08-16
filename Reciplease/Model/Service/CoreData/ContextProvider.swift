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
    
    static func getContext(
        shouldBeInMemory: Bool,
        fromContainer container: NSPersistentContainer = NSPersistentContainer(name: "Reciplease"),
        stopExecution: @escaping (@autoclosure () -> String, StaticString, UInt) -> Never
            = Swift.fatalError) -> NSManagedObjectContext {
        
        
        if shouldBeInMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            description.shouldAddStoreAsynchronously = false
            
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, _ in }
        
        let context = container.viewContext
        return context
    }
    
    
    init(context: NSManagedObjectContext = getContext(shouldBeInMemory: false)) {
        self.context = context
    }
    
    let context: NSManagedObjectContext
    
    
    
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
