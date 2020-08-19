//
//  STMTaskDetail_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

enum STMTaskDetailEnum: CaseIterable {
    case title, category, dueDate, description, status, notification
}
//
protocol STMStoreDataDelegate: class {
    func saveTask()
}
//
protocol STMRecordDetailProtocol: class {
    func updateDetailModel(with type: STMTaskDetailEnum, value: AnyObject)
}

extension STMTaskDetail_VC: STMRecordDetailProtocol {
    func updateDetailModel(with type: STMTaskDetailEnum, value: AnyObject) {
        viewModel.updateModel(with: type, value: value)
    }
}

extension STMTaskDetail_VC: STMTaskList_TVC_Delegate {
    func reloadData() {
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 5)], with: .fade)
    }
}

extension STMTaskDetail_VC: STMStoreDataDelegate {
    func saveTask() {
        if viewModel.addNewTask() {
            self.navigationController?.popViewController(animated: true)
        } else {
            showIncorectTitleAlert()
        }
    }
}

extension STMTaskDetail_VC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        STMTaskDetailEnum.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 140
        case 2: return 240
        case 3: return 220
        default: return 75
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0: let cell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetail_Title_TVCell.self), for: indexPath) as! STMDetail_Title_TVCell
            cell.textField.text = viewModel.taskTitle
            cell.delegate = self
            return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailCategoty_TVCell.self), for: indexPath) as! STMDetailCategoty_TVCell
            cell.picker.selectRow(STMCategory.allCategories.firstIndex(of: viewModel.taskCategory)!,
                                        inComponent: 0,
                                        animated: true)
            cell.delegate = self
            return cell
            
        case 2: let cell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailDueDate_TVCell.self), for: indexPath) as! STMDetailDueDate_TVCell
            cell.theDatePicker.setDate(viewModel.taskDueDate, animated: true)
            cell.delegate = self
            return cell
            
        case 3: let cell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailTextView_TVCell.self), for: indexPath) as! STMDetailTextView_TVCell
            cell.taskDescription.text = viewModel.taskDesription
            cell.delegate = self
            return cell
            
        case 4: let cell = tableView.dequeueReusableCell(withIdentifier:
            String(describing: STMDetailNotification_TVCell.self), for: indexPath) as! STMDetailNotification_TVCell
            cell.theSwitch.isOn = viewModel.taskNotificationStatus
            cell.delegate = self
            return cell
        // alternate behaviour according to the action
        case 5:
            if let task = viewModel.task {
                let cell = tableView.dequeueReusableCell(withIdentifier:
                String(describing: STMConfirmButton_TVCell.self), for: indexPath) as! STMConfirmButton_TVCell
                cell.taskRecord = task
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier:
                String(describing: STMDetailAddButton_TVCell.self), for: indexPath) as! STMDetailAddButton_TVCell
                cell.delegate = self
                return cell
            }
            
        default: break
        }
        
        return UITableViewCell()
    }
}

class STMTaskDetail_VC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: STMTaskDetail_VMNew!
    //
    @objc func saveAction(sender: UIButton) {
        if viewModel.hasBeenUpdated {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel.task != nil {
            let saveButton = UIBarButtonItem(title: "Save",
                                             style: .done,
                                             target: self,
                                             action: #selector(STMTaskDetail_VC.saveAction(sender:)))
            
            self.navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    //
    private func updateRecentValues() {
        if viewModel.isEligable {
            viewModel.editTask()
        } else {
            showIncorectTitleAlert()
        }
    }
}
