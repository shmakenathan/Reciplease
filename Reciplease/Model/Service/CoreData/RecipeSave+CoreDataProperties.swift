//
//  RecipeSave+CoreDataProperties.swift
//  
//
//  Created by Nathan on 11/12/2020.
//
//

import Foundation
import CoreData


extension RecipeSave {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeSave> {
        return NSFetchRequest<RecipeSave>(entityName: "RecipeSave")
    }

    @NSManaged public var image: String?
    @NSManaged public var ingredient: [String]?
    @NSManaged public var time: Int64
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
