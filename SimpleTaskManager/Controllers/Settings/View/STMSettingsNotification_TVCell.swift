//
//  STMSettingsNotification_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMSettingsNotification_TVCell: UITableViewCell {
    @IBOutlet weak var cellSwitch: UISwitch!
    
    private var viewModel: STMSettings_VM!
    
    func configure(with viewModel: STMSettings_VM) {
        self.viewModel = viewModel
        cellSwitch.setOn(viewModel.initialNotificationState,
                         animated: true)
        
        guard viewModel.numberOfTasks != 0 else {
            cellSwitch.isUserInteractionEnabled = false
            return
        }
        
        cellSwitch.addTarget(self,
                             action: #selector(manageSwitch(_:)),
                             for: .touchUpInside)
    }
    
    @objc func manageSwitch(_ swtch: UISwitch) {
        viewModel.notificationsChanged(swtch.isOn)
    }
}
