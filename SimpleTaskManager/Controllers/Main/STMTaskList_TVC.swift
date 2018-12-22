//
//  STMTaskList_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

protocol STMTaskList_TVC_Delegate: class {
    //
    func reloadData()
}
//
extension STMTaskList_TVC: STMTaskList_TVC_Delegate {
    //
    func reloadData() {
        self.reloadRecords()
        self.tableView.reloadData()
    }
}
///
class STMTaskList_TVC: UITableViewController {
    // TODO: detailViewModel instead of Records
    var completedTasks = [STMRecord]()
    //
    var incompletedTasks = [STMRecord]()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        self.reloadData()
    }
    
    //
    private func reloadRecords() {
        //
        completedTasks = STMRecord.getAllTasks(completed: true)
        incompletedTasks = STMRecord.getAllTasks(completed: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    // Split Table View according to the completition state
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return completedTasks.count + incompletedTasks.count > 0 ? 2 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? incompletedTasks.count : completedTasks.count
    }
    
    //
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? STMTaskStatus.incompleteTask.tableHeaderTitle:STMTaskStatus.completeTask.tableHeaderTitle
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        return 110
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: STMMain_TVCell.self), for: indexPath) as? STMMain_TVCell {
            //
            func assignColor(for task:STMRecord) {
                //
                let color = task.taskCategory?.backgroundColor
                //
                cell.delegate = self
                cell.backgroundColor = UIColor(ciColor: CIColor(string: color!)).withAlphaComponent(0.1)
            }
            //
            switch indexPath.section {
            case 0: cell.theTaskRecord = incompletedTasks[indexPath.row]
            assignColor(for: cell.theTaskRecord!)
            default: cell.theTaskRecord = completedTasks[indexPath.row]
            assignColor(for: cell.theTaskRecord!)
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theTask = indexPath.section == 0 ? incompletedTasks[indexPath.row]:completedTasks[indexPath.row]
        self.performSegue(withIdentifier: "showTaskDetail", sender: theTask)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if indexPath.section == 0 {
                STMTaskAction.deleteTask(id: incompletedTasks[indexPath.row].id!).manageTask()
            } else {
                STMTaskAction.deleteTask(id: completedTasks[indexPath.row].id!).manageTask()
            }
            //
            reloadRecords()
            //
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showTaskDetail" {
            //
            if let controller = segue.destination as? STMTaskDetail_TVC {
                if let theTask = sender as? STMRecord {
                    controller.task = theTask
                }
            }
        }
    }
}
