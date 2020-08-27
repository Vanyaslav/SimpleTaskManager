//
//  STMTaskList_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

//
extension STMTaskList_TVC {
    func reloadData() {
        viewModel.reloadRecords()
        self.tableView.reloadData()
    }
}
///
class STMTaskList_TVC: UITableViewController {
    var viewModel: STMTaskList_VM!
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.reloadData()
    }

    // MARK: - Table view data source
    // Split Table View according to the completition state
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfItems > 0
            ? 2
            : 0
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        section == 0
            ? viewModel.incompletedTasks.count
            : viewModel.completedTasks.count
    }
    
    //
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        section == 0
            ? STMTaskStatusEnum.incompleteTask.tableHeaderTitle
            : STMTaskStatusEnum.completeTask.tableHeaderTitle
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: STMMain_TVCell = tableView.dequeueReusableCell(for: indexPath)
        
        func assignColor(for task: STMRecord, selected: Bool) {
            if let color = task.taskCategory?.backgroundColor {
                cell.backgroundColor = UIColor(ciColor: CIColor(string: color)).withAlphaComponent(0.1)
            }
            
            // cell.delegate = self
            cell.titelLabel.text = task.taskTitle
            cell.dueDateLabel.text = task.taskDueDate?.getString(with: .long)
            cell.manageButton.isSelected = selected
        }
            
        switch indexPath.section {
        case 0: assignColor(for: viewModel.incompletedTasks[indexPath.row], selected: false)
        default: assignColor(for: viewModel.completedTasks[indexPath.row], selected: true)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let task = indexPath.section == 0
            ? viewModel.incompletedTasks[indexPath.row]
            : viewModel.completedTasks[indexPath.row]
        
        self.performSegue(withIdentifier: "showTaskDetail", sender: task)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel.deleteRecords(in: indexPath)
            //
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }   
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? STMTaskDetail_VC {
            if let task = sender as? STMRecord {
                controller.viewModel = STMTaskDetail_VM(task: task)
            } else {
                controller.viewModel = STMTaskDetail_VM()
            }
        }
        
        if let controller = segue.destination as? STMSettings_TVC {
            controller.viewModel = STMSettings_VM()
        }
    }
}
