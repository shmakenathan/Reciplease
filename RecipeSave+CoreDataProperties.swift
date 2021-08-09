//
//  RecipeSave+CoreDataProperties.swift
//  Reciplease
//
//  Created by Nathan on 06/08/2021.
//  Copyright © 2021 NathanChicha. All rights reserved.
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
    @NSManaged public var calories: Double
    @NSManaged public var cuisineType: [String]?

}

extension RecipeSave : Identifiable {

}
