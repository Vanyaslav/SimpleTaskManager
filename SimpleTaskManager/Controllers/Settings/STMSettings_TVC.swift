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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 1
            ? 190
            : 103
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier:
                String(describing: STMButton_TVCell.self), for: indexPath) as? STMButton_TVCell {
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier:
                String(describing: STMOrderingPicker_TVCell.self), for: indexPath) as? STMOrderingPicker_TVCell {
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: STMSettingsNotification_TVCell.self), for: indexPath) as? STMSettingsNotification_TVCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
