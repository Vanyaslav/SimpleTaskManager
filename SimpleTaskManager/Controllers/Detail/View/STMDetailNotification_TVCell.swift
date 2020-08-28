//
//  STMDetailNotification_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMDetailNotification_TVCell: UITableViewCell {
    @IBOutlet weak var cellSwitch: UISwitch!
    
    private var viewModel: STMTaskDetail_VM!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        cellSwitch.isOn = viewModel.taskNotificationStatus
        cellSwitch.addTarget(self,
                            action: #selector(manageSwitch(_:)),
                            for: .touchUpInside)
    }
    
    @objc func manageSwitch(_ swtch: UISwitch) {
        viewModel.taskNotificationStatus = swtch.isOn
    }
}
