//
//  STMSettings_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 23/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

class STMSettings_VM {
    func notificationsChanged(_ status: Bool) {
        STMRecord.updateAllTaskNotification(isOn: status)
    }
    
    func initialNotificationState() -> Bool {
        let globalStatus = STMRecord.getAllTasks().map({ task in
            task.isNotificationOn == true
        })
        
        if globalStatus.count == STMRecord.getAllTasks().count {
            return true
        }
        
        return false
    }
    
    func initialOrderinPicker() -> ([(row: Int, component: Int)]) {
        var items = [(row: Int, component: Int)]()
        items.append((row: STMOrderingMannerEnum.getStored().rawValue, component: 1))
        items.append((row: STMOrderingTypeEnum.getStored().rawValue, component: 0))
        return items
    }
}
