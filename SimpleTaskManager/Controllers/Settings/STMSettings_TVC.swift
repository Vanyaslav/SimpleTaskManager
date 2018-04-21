//
//  STMSettings_TVC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

///
class STMSettings_TVC: UITableViewController {
    
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
        case 1: return 190
        default: return 103
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        var cell = UITableViewCell()
        // Configure the cell...
        switch indexPath.section {
        case 0:
            if let theCell = tableView.dequeueReusableCell(withIdentifier:
                String(describing: STMButton_TVCell.self), for: indexPath) as? STMButton_TVCell {
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
                cell =  theCell
            }
        }
        //
        return cell
    }
}
