//
//  STMTaskDetail_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

extension STMTaskDetail_VC {
    @IBAction func respondTouch() {
        titleTextView.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }
}

extension STMTaskDetail_VC: STMDetailAddButton_TVCellDelegate {
    func processedTask(with result: Bool) {
        result
            ? self.navigationController?
                .popViewController(animated: true)
                .map{ _ in }
            : showIncorectTitleAlert()
    }
}

extension STMTaskDetail_VC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: STMDetailTaskTitle_TVCell = tableView
                .dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            titleTextView = cell.textField
            return cell
        case 1:
            let cell: STMDetailCategoty_TVCell = tableView
                .dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case 2:
            let cell: STMDetailDueDate_TVCell = tableView
                .dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case 3:
            let cell: STMDetailTextView_TVCell = tableView
                .dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            descriptionTextView = cell.taskDescription
            return cell
        case 4:
            let cell: STMDetailNotification_TVCell = tableView
                .dequeueReusableCell(for: indexPath)
            cell.configure(with: viewModel)
            return cell
        // alternate behaviour according to the action
        case 5:
            if viewModel.isEditing {
                let cell: STMConfirmButton_TVCell = tableView
                    .dequeueReusableCell(for: indexPath)
                cell.configure(with: viewModel)
                return cell
            } else {
                let cell: STMDetailAddButton_TVCell = tableView
                    .dequeueReusableCell(for: indexPath)
                cell.configure(with: viewModel)
                cell.delagate = self
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
}

class STMTaskDetail_VC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    // holding references to resign responder
    private weak var titleTextView: UITextField!
    private weak var descriptionTextView: UITextView!
    
    var viewModel: STMTaskDetail_VM!
    
    @objc func saveAction(sender: UIButton) {
        if viewModel.didUpdate {
            showUpdateAlert(with: { confirmAction in
                if !self.viewModel.editTask() {
                    self.showIncorectTitleAlert()
                }
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
        
        if viewModel.isEditing {
            let saveButton = UIBarButtonItem(title: "Back",
                                             style: .done,
                                             target: self,
                                             action: #selector(saveAction(sender:)))
            
            self.navigationItem.leftBarButtonItem = saveButton
        }
    }
}
