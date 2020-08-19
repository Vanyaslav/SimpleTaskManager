//
//  STMTaskList_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

protocol STMTaskList_TVC_Delegate: class {
    func reloadData()
}
//
extension STMTaskList_TVC: STMTaskList_TVC_Delegate {
    func reloadData() {
        viewModel.reloadRecords()
        self.tableView.reloadData()
    }
}
///
class STMTaskList_TVC: UITableViewController {
    var viewModel: STMTaskList_VM!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }
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
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: STMMain_TVCell = tableView.dequeueReusableCell(for: indexPath)
            func assignColor(for task:STMRecord) {
                let color = task.taskCategory?.backgroundColor
                
                cell.delegate = self
                cell.backgroundColor = UIColor(ciColor: CIColor(string: color!)).withAlphaComponent(0.1)
            }
            
        switch indexPath.section {
        case 0: cell.taskRecord = viewModel.incompletedTasks[indexPath.row]
            assignColor(for: cell.taskRecord!)
        default: cell.taskRecord = viewModel.completedTasks[indexPath.row]
            assignColor(for: cell.taskRecord!)
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
                            commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            viewModel.deleteRecords(in: indexPath)
            //
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }   
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showTaskDetail" {
            if let controller = segue.destination as? STMTaskDetail_VC {
                guard let task = sender as? STMRecord else { return }
                controller.viewModel = STMTaskDetail_VM(task: task)
            }
        }
        
        if segue.identifier == "addNewTask" {
            if let controller = segue.destination as? STMTaskDetail_VC {
                controller.viewModel = STMTaskDetail_VM(task: nil)
            }
        }
    }
}
