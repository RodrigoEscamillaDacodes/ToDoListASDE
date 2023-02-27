//
//  ListViewModel.swift
//  ToDoListAD
//
//  Created by MacBookDacodes on 27/02/23.
//

import Foundation


final class ListViewModel{
    
    init(){
        getInfo()
    }
        
    var obsvTasks: Observable <[Task]> = Observable([])
    
    var tasksCount: Int {
        return obsvTasks.value.count
    }
    
    
    private func getInfo(){
        
        var tasks : [Task] = []
        
        let storagedTasks = TaskMOServices.shared.fetchTasks()
        
        for taskMO in storagedTasks{
            let task = Task(id: taskMO.id, name: taskMO.task, completed: taskMO.completed, priority: taskMO.priority)
            tasks.append(task)
        }
        
        obsvTasks.value = tasks
        
    }
    
    func delete(index: Int){
        let selectedTask = obsvTasks.value[index]
        obsvTasks.value.remove(at: index)
        TaskMOServices.shared.deleteTask(id: selectedTask.id)
    }
    
    func insert(task: Task){
        TaskMOServices.shared.saveTask(task: task)
        getInfo()
    }
    
    func taskAtPosition(index: Int) -> Task {
        return obsvTasks.value[index]
    }
    
}
