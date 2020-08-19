//
//  STMSettingsNotification_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMSettingsNotification_TVCell: STMSwitch_TVCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.isGlobal = true
        //
        let globalStatus = STMRecord.getAllTasks().map({ task in
            task.isNotificationOn == true
        })
        
        if globalStatus.count == STMRecord.getAllTasks().count {
            self.theSwitch.isOn = true
        }
    }
}
