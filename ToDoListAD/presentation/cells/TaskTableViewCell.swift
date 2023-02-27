//
//  TaskTableViewCell.swift
//  ToDoListAD
//
//  Created by MacBookDacodes on 27/02/23.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    private var task : Task? = nil
    
    @IBOutlet weak var completedCheckBox: CheckBox!{
        didSet{
            completedCheckBox.style = .tick
            completedCheckBox.borderStyle = .rounded
        }
    }
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!{
        didSet{
            priorityImage.layer.masksToBounds = false
            priorityImage.layer.cornerRadius = priorityImage.frame.width/2
            priorityImage.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(task: Task){
        self.task = task
        taskLabel.text = task.name
        
        completedCheckBox.isChecked = task.completed
        
        switch task.priority {
        case 1:
            priorityImage.backgroundColor = .red
        case 2:
            priorityImage.backgroundColor = .orange
        case 3:
            priorityImage.backgroundColor = .yellow
        default:
            break
        }
    }
    
    @IBAction func completeAction(_ sender: Any) {
        guard let task = task else {return}
        TaskMOServices.shared.editTaks(id: task.id, completed: completedCheckBox.isChecked)
    }
    
}
