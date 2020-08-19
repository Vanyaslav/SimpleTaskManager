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
    weak var delegate: STMRecordDetailProtocol?
    
    @IBOutlet weak var cellSwitch: UISwitch!
    // notification
    var isGlobal = false
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellSwitch.addTarget(self, action: #selector(manageSwitch), for: .touchUpInside)
    }
    //
    @objc func manageSwitch() {
        // manage all notifications
        if isGlobal {
            if STMRecord.getAllTasks().count == 0 {
                cellSwitch.setOn(false, animated: true)
                return
            }
            //
            STMRecord.updateAllTaskNotification(isOn: cellSwitch.isOn)
        } else {
            delegate?.updateDetailModel(with: .notification, value: cellSwitch.isOn as AnyObject)
        }
    }
}
