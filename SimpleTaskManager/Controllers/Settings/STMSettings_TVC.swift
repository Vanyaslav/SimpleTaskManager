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
        3
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 1
            ? 190
            : 103
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell: STMButton_TVCell = tableView.dequeueReusableCell(for: indexPath)
            return cell

        case 1:
            let cell: STMOrderingPicker_TVCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
            
        case 2:
            let cell: STMSettingsNotification_TVCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
            
        default:
            break
        }
        
        return UITableViewCell()
    }
}
