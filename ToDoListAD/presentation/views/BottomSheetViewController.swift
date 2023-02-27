//
//  BottomSheetViewController.swift
//  ToDoListAD
//
//  Created by MacBookDacodes on 27/02/23.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIButton!{
        didSet{
            saveButton.layer.cornerRadius = 10
            saveButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
    }
    
    var saveDataCallback:((Task) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveAction(_ sender: Any) {
        
        guard let task = taskTextField.text else {return}
        
        if task.isEmpty{
            let alert = UIAlertController(title: "ToDo list", message: "Please, compleate task field.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Acept", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let priority = prioritySegmentedControl.selectedSegmentIndex + 1
        
        let taskModel = Task(name: task, priority: priority)
        
        saveDataCallback?(taskModel)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
