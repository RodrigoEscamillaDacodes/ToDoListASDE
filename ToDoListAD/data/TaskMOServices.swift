//
//  TaskMOServices.swift
//  ToDoListAD
//
//  Created by MacBookDacodes on 27/02/23.
//

import UIKit
import CoreData

class TaskMOServices {
    
    static let shared: TaskMOServices = TaskMOServices()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks = [TaskMO]()
    
    func fetchTasks() -> [TaskMO] {
        do {
            tasks = try context.fetch(TaskMO.fetchRequest())
        } catch {
            fatalError("Failure to retrieve: \(error)")
        }
        
        return tasks
    }
    
    func saveTask(task: Task){
        let newTask = TaskMO(context: self.context)
        newTask.id = UUID().uuidString
        newTask.task = task.name
        newTask.completed = task.completed
        newTask.priority = task.priority
        
        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func editTaks(id: String, completed: Bool) {
        do {
            let tasks = try context.fetch(TaskMO.fetchRequest(id: id))
            tasks.first?.completed = completed
            try context.save()
        } catch {
            fatalError("Failure to retrieve: \(error)")
        }
    }
    
    func deleteTask(id: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskMO")
        deleteFetch.predicate = NSPredicate(format: "id = %@", id)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}
