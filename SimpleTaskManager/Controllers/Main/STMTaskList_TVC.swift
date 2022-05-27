//
//  STMTaskList_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit


protocol STMTaskList_TVCDelegate: AnyObject {
    func reloadData()
}
//
extension STMTaskList_TVC: STMTaskList_TVCDelegate {
    func reloadData() {
        viewModel.reloadRecords()
        self.tableView.reloadData()
    }
}
///
class STMTaskList_TVC: UITableViewController {
    private let viewModel = STMTaskList_VM()
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadData()
    }

    // MARK: - Table view data source
    // Split Table View according to the completition state
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    //
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        viewModel.tableHeaderTitle(in: section)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: STMMain_TVCell = tableView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.configure(with: viewModel, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        let task = viewModel.getRecord(with: indexPath)
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
            controller.viewModel = viewModel.taskDetailViewModel(record: (sender as? STMRecord))
        }
        
        if let controller = segue.destination as? STMSettings_TVC {
            controller.viewModel = viewModel.settingsViewModel
        }
    }
}
