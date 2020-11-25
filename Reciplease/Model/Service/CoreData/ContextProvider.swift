//
//  ContextProvider.swift
//  Reciplease
//
//  Created by Nathan on 20/11/2020.
//  Copyright © 2020 NathanChicha. All rights reserved.
//

import CoreData

class ContextProvider {
    
    static func getContext(
        fromContainer container: NSPersistentContainer = NSPersistentContainer(name: "Reciplease"),
        stopExecution: @escaping (@autoclosure () -> String, StaticString, UInt) -> Never
        = Swift.fatalError) -> NSManagedObjectContext {

        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                stopExecution("Unresolved error \(error), \(error.userInfo)", #file, #line)
            }
        }
        let context = container.viewContext
        return context
    }
    
    
    init(context: NSManagedObjectContext = getContext()) {
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
