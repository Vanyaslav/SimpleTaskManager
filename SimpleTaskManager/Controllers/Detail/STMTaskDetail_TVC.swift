//
//  STMTaskDetail_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
//
struct DetailModel {
    //
    var theTitle: String?
    //
    var theCategory: STMCategory = STMCategoryData().taskCategories[0]
    //
    var theDueDate = Date()
    //
    var theTaskDesription: String = ""
    //
    var theNotificationStatus = false
    //
    var theTaskStatus = false
    ///
    var isEligable: Bool {
        guard let title = theTitle, title.count > 2 else {
            return false
        }
        return true
    }
    //
    mutating func initModel(with task:STMRecord) {
        //
        theTitle = task.taskTitle
        theCategory = task.taskCategory!
        theDueDate = task.taskDueDate!
        theTaskDesription = task.taskDescription!
        theNotificationStatus = task.isNotificationOn
        theTaskStatus = task.isFinished
    }
}
//
enum DetailType: Int {
    //
    case title = 0, category, dueDate, description, status, notification
    //
    static var count: Int { return DetailType.notification.rawValue + 1 }
}
//
protocol STMStoreDataDelegate: AnyObject {
    //
    func saveTask()
}
//
protocol RecordDetailProtocol: AnyObject {
    //
    func updateDetailModel(with type: DetailType, value:AnyObject)
}
//
extension STMTaskDetail_TVC: RecordDetailProtocol {
    //
    func updateDetailModel(with type: DetailType, value:AnyObject) {
        //
        switch type {
        case .title: theDetailModel.theTitle = (value as! String)
        case .category: theDetailModel.theCategory = (value as! STMCategory)
        case .dueDate: theDetailModel.theDueDate = (value as! Date)
        case .description: theDetailModel.theTaskDesription = (value as! String)
        case .status: theDetailModel.theTaskStatus = (value as! Bool)
        case .notification: theDetailModel.theNotificationStatus = (value as! Bool)
        }
        //
        self.hasBeenUpdated = true
    }
}

//
extension STMTaskDetail_TVC: STMStoreDataDelegate {
    //
    func saveTask() {
        //
        if theDetailModel.isEligable {
            //
            STMTaskAction.addNew(titel: theDetailModel.theTitle!,
                                 category: theDetailModel.theCategory,
                                 dueDate: theDetailModel.theDueDate,
                                 description: theDetailModel.theTaskDesription,
                                 isNotified: theDetailModel.theNotificationStatus).manageTask()
            //
            self.navigationController?.popViewController(animated: true)
        } else {
            showIncorectTitelAlert()
        }
    }
}
//
extension STMTaskDetail_TVC: STMTaskList_TVC_Delegate {
    //
    func reloadData() {
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .fade)
    }
}
/// add and edit task
class STMTaskDetail_TVC: UITableViewController {
    //
    private var theDetailModel = DetailModel()
    //
    // if task available then Edit/Review mode else Add New task mode
    // TODO: let view know nothing about Model
    var task: STMRecord? {
        //
        didSet {
            theDetailModel.initModel(with: task!)
        }
    }
    //
    var hasBeenUpdated = false
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        if task != nil {
            let backButton = UIBarButtonItem(title: "Save",
                                             style: .done,
                                             target: self,
                                             action: #selector(STMTaskDetail_TVC.saveAction(sender:)))
            self.navigationItem.rightBarButtonItem = backButton
        }
    }

    //
    @objc func saveAction(sender:UIButton) {
        //
        if hasBeenUpdated {
            showUpdateAlert(with: { confirmAction in
                // update
                self.updateRecentValues()
                self.pushControllerBack(animated: true)
                
            }, cancelAction: { cancelAction in
                //
                self.pushControllerBack(animated: true)
            })
        } else {
            self.pushControllerBack(animated: true)
        }
    }
    
    //
    private func updateRecentValues() {
        //
        if theDetailModel.isEligable {
            STMTaskAction.edit(id: (task?.id)!,
                               titel: theDetailModel.theTitle!,
                               category: theDetailModel.theCategory,
                               dueDate: theDetailModel.theDueDate,
                               description: theDetailModel.theTaskDesription).manageTask()

            STMRecord.updateTaskNotification(with:task!, isNotified:theDetailModel.theNotificationStatus)
            STMRecord.manageTaskStatus(with:task!, isFinished:theDetailModel.theTaskStatus)
        } else {
            showIncorectTitelAlert()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return DetailType.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //
        switch indexPath.section {
        case 1: return 140
        case 2: return 240
        case 3: return 220
        default: return 75
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        var cell = UITableViewCell()
        //
        switch indexPath.section {
            
        case 0: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetail_Title_TVCell.self), for: indexPath) as! STMDetail_Title_TVCell
            theCell.theTextField.text = theDetailModel.theTitle
            theCell.delegate = self
            cell = theCell
            
        case 1: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailCategoty_TVCell.self), for: indexPath) as! STMDetailCategoty_TVCell
            theCell.thePicker.selectRow(STMCategoryData().taskCategories.index(of: theDetailModel.theCategory)!,
                                        inComponent: 0,
                                        animated: true)
            theCell.delegate = self
            cell = theCell
            
        case 2: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailDueDate_TVCell.self), for: indexPath) as! STMDetailDueDate_TVCell
            theCell.theDatePicker.setDate(theDetailModel.theDueDate, animated: true)
            theCell.delegate = self
            cell = theCell
            
        case 3: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailTextView_TVCell.self), for: indexPath) as! STMDetailTextView_TVCell
            theCell.taskDescription.text = theDetailModel.theTaskDesription
            theCell.delegate = self
            cell = theCell
            
        case 4: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailNotification_TVCell.self), for: indexPath) as! STMDetailNotification_TVCell
            theCell.theSwitch.isOn = theDetailModel.theNotificationStatus
            theCell.delegate = self
            cell = theCell
        // alternate behaviour according to the action
        case 5:
            if let theTask=task {
                let theCell = tableView.dequeueReusableCell(withIdentifier:
                String(describing: STMConfirmButton_TVCell.self), for: indexPath) as! STMConfirmButton_TVCell
                theCell.theTaskRecord = theTask
                theCell.delegate = self
                cell = theCell
            } else {
                let theCell = tableView.dequeueReusableCell(withIdentifier:
                String(describing: STMDetailAddButton_TVCell.self), for: indexPath) as! STMDetailAddButton_TVCell
                theCell.delegate = self
                cell = theCell
                
            }
            
        default: break
        }
        //
        return cell
    }
    //
    // MARK: - Util functions
    //
    private func getIndexRow(from category:STMCategory) -> Int {
        guard let row = STMCategoryData().taskCategories.index(of: category) else {
            return 0
        }
        return row
    }
}
