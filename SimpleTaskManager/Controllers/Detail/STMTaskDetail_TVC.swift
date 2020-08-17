//
//  STMTaskDetail_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

//
enum DetailType: Int, CaseIterable {
    case title = 0, category, dueDate, description, status, notification
}
//
protocol STMStoreDataDelegate: AnyObject {
    func saveTask()
}
//
protocol STMRecordDetailProtocol: AnyObject {
    func updateDetailModel(with type: DetailType, value:AnyObject)
}
//
extension STMTaskDetail_TVC: STMRecordDetailProtocol {
    func updateDetailModel(with type: DetailType, value: AnyObject) {
        switch type {
        case .title: viewModel.taskTitle = (value as! String)
        case .category: viewModel.taskCategory = (value as! STMCategory)
        case .dueDate: viewModel.taskDueDate = (value as! Date)
        case .description: viewModel.taskDesription = (value as! String)
        case .status: viewModel.taskStatus = (value as! Bool)
        case .notification: viewModel.taskNotificationStatus = (value as! Bool)
        }
        //
        self.hasBeenUpdated = true
    }
}

//
extension STMTaskDetail_TVC: STMStoreDataDelegate {
    func saveTask() {
        if viewModel.isEligable {
            STMTaskAction.addNew(titel: viewModel.taskTitle,
                                 category: viewModel.taskCategory,
                                 dueDate: viewModel.taskDueDate,
                                 description: viewModel.taskDesription,
                                 isNotified: viewModel.taskNotificationStatus).manageTask()
            
            self.navigationController?.popViewController(animated: true)
        } else {
            showIncorectTitelAlert()
        }
    }
}
//
extension STMTaskDetail_TVC: STMTaskList_TVC_Delegate {
    func reloadData() {
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .fade)
    }
}
/// add and edit task
class STMTaskDetail_TVC: UITableViewController {
    private var viewModel = STMTaskDetail_VM()
    //
    // if task available then Edit/Review mode else Add New task mode
    var task: STMRecord? {
        didSet {
            viewModel.initModel(with: task!)
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
    @objc func saveAction(sender: UIButton) {
        if hasBeenUpdated {
            showUpdateAlert(with: { confirmAction in
                // update
                self.updateRecentValues()
                self.pushControllerBack(animated: true)
                
            }, cancelAction: { cancelAction in
                self.pushControllerBack(animated: true)
            })
        } else {
            self.pushControllerBack(animated: true)
        }
    }
    
    //
    private func updateRecentValues() {
        if viewModel.isEligable {
            guard let task = self.task else {
                return
            }
            STMTaskAction.edit(id: task.id!,
                               titel: viewModel.taskTitle,
                               category: viewModel.taskCategory,
                               dueDate: viewModel.taskDueDate,
                               description: viewModel.taskDesription)
                .manageTask()

            STMRecord.updateTaskNotification(with: task, isNotified: viewModel.taskNotificationStatus)
            STMRecord.manageTaskStatus(with: task, isFinished: viewModel.taskStatus)
        } else {
            showIncorectTitelAlert()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return DetailType.allCases.count
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
            theCell.textField.text = viewModel.taskTitle
            theCell.delegate = self
            cell = theCell
            
        case 1: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailCategoty_TVCell.self), for: indexPath) as! STMDetailCategoty_TVCell
            theCell.thePicker.selectRow(STMCategory.allCategories.firstIndex(of: viewModel.taskCategory)!,
                                        inComponent: 0,
                                        animated: true)
            theCell.delegate = self
            cell = theCell
            
        case 2: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailDueDate_TVCell.self), for: indexPath) as! STMDetailDueDate_TVCell
            theCell.theDatePicker.setDate(viewModel.taskDueDate, animated: true)
            theCell.delegate = self
            cell = theCell
            
        case 3: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailTextView_TVCell.self), for: indexPath) as! STMDetailTextView_TVCell
            theCell.taskDescription.text = viewModel.taskDesription
            theCell.delegate = self
            cell = theCell
            
        case 4: let theCell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailNotification_TVCell.self), for: indexPath) as! STMDetailNotification_TVCell
            theCell.theSwitch.isOn = viewModel.taskNotificationStatus
            theCell.delegate = self
            cell = theCell
        // alternate behaviour according to the action
        case 5:
            if let theTask = task {
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
        guard let row = STMCategory.allCategories.firstIndex(of: category) else {
            return 0
        }
        return row
    }
}
