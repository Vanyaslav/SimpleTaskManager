//
//  STMTaskDetail_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
//
protocol STMStoreDataDelegate {
    //
    func saveTask()
}
///
class STMTaskDetail_TVC: UITableViewController, STMStoreDataDelegate {
    //
    func saveTask() {
        //STMTaskAction.addNewTask(titel: taskTitle.text, category: category, dueDate: taskDueDateLabel.text, description: taskDesription.text).manageTask()
    }
    //
    var taskID:UUID?
    //
    var isTaskBeingEditing = false
    //
    @IBOutlet var taskDesription:UITextView!
    //
    @IBOutlet var taskDueDateLabel:UILabel!
    //
    @IBOutlet var taskTitle:UILabel!
    //
    @IBOutlet var enableNotificationSwitch:UISwitch!
    //
    @IBOutlet var manageTaskButton:UIButton!
    ///
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //
        if isTaskBeingEditing {
            //
            if let record = STMRecord.getTask(with:taskID!) {
                taskTitle.text = record.taskTitle
                taskDueDateLabel.text = record.taskDueDate?.description
                taskDesription.text = record.detail?.taskDescription
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        var cell = UITableViewCell()
        //
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        default:
            if isTaskBeingEditing {
                cell = tableView.dequeueReusableCell(withIdentifier:
                        String(describing: STMConfirmButton_TVCell.self), for: indexPath) as! STMConfirmButton_TVCell
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier:
                        String(describing: STMDetailAddButton_TVCell.self), for: indexPath) as! STMDetailAddButton_TVCell
            }

        }

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
