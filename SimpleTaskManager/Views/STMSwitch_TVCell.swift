//
//  STMSwitch_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
// Used for notifications cells
class STMSwitch_TVCell: UITableViewCell {
    //
    @IBOutlet var theSwitch: UISwitch!
    // notification
    var isGlobal = false
    // specific task - used only on detail record
    var taskId:UUID?
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        theSwitch.addTarget(self, action: #selector(manageSwitch), for: .touchUpInside)
    }
    //
    @objc func manageSwitch() {
        // manage all notifications
        if isGlobal {
            if STMRecord.getAllTasks().count == 0 {
                theSwitch.isOn = false
                return
            }
            STMRecord.manageAllTaskNotification(isOn: theSwitch.isOn ? true : false)
            // manage specific one
        } else {
            if let theTaskId = taskId {
                STMRecord.manageTaskNotification(with: theTaskId, isNotified: theSwitch.isOn ? true:false)
            }
        }
    }
}
