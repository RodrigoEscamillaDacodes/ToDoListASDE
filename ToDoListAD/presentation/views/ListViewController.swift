//
//  ListViewController.swift
//  ToDoListAD
//
//  Created by MacBookDacodes on 27/02/23.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableViewTasks: UITableView!
    
    private var viewModel: ListViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ListViewModel()
        bind()
        setupTable()
    }
    
    private func setupTable(){
        tableViewTasks.delegate = self
        tableViewTasks.dataSource = self
    }
    
    private func bind(){
        viewModel.obsvTasks.observe(on: self) { [weak self]_ in
            self?.tableViewTasks.reloadData()
        }
    }
        
    @IBAction func addAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BottomSheetTask") as! BottomSheetViewController
        
        vc.modalPresentationStyle = .popover
        
        vc.saveDataCallback = { task in
            self.viewModel.insert(task: task)
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        
        cell.setup(task: viewModel.taskAtPosition(index: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.delete(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
