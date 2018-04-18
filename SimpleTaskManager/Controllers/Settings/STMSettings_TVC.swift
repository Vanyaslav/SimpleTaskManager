//
//  STMSettings_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

//
protocol STMSettings_TVC_Delegate {
    //
    func pushAddCategoryController()
}
///
class STMSettings_TVC: UITableViewController, STMSettings_TVC_Delegate {
    //
    func pushAddCategoryController() {
        performSegue(withIdentifier: "addNewCategory", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    //
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1: return 189
        default: return 103
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        var cell = UITableViewCell()
        // Configure the cell...
        if indexPath.row == 0 {
            switch indexPath.section {
            case 0:
                if let theCell = tableView.dequeueReusableCell(withIdentifier:
                    String(describing: STMAddCategory_TVCell.self), for: indexPath) as? STMAddCategory_TVCell {
                    cell = theCell
                }
            case 1:
                if let theCell = tableView.dequeueReusableCell(withIdentifier:
                    String(describing: STMOrderingPicker_TVCell.self), for: indexPath) as? STMOrderingPicker_TVCell {
                    cell =  theCell
                }
            default:
                if let theCell = tableView.dequeueReusableCell(withIdentifier:
                    String(describing: STMSettingsNotification_TVCell.self), for: indexPath) as? STMSettingsNotification_TVCell {
                    theCell.isGlobal = true
                    cell =  theCell
                }
            }
        }
        //
        return cell
    }
    
}
