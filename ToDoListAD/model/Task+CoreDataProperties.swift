//
//  Task+CoreDataProperties.swift
//  ToDoListAD
//
//  Created by MacBookDacodes on 27/02/23.
//

import Foundation
import CoreData

extension TaskMO{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskMO> {
        return NSFetchRequest<TaskMO>(entityName: "TaskMO")
    }
    
    @nonobjc public class func fetchRequest(id: String) -> NSFetchRequest<TaskMO> {
        let request = NSFetchRequest<TaskMO>(entityName: "TaskMO")
        request.predicate = NSPredicate(format: "id = %@", id)
        return request
    }
   
    @NSManaged public var id: String
    @NSManaged public var task: String
    @NSManaged public var completed: Bool
    @NSManaged public var priority: Int
}
