//
//  STMSettings_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 23/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

class STMSettings_VM {
    var numberOfTasks: Int {
        return dataService.getRecords().count
    }
    
    let dataService: STMDataService

    init(dataService: STMDataService) {
        self.dataService = dataService
    }
    
    func notificationsChanged(_ status: Bool) {
        dataService.updateGlobalNotification(with: status)
    }
    //
    var initialNotificationState: Bool {
        guard dataService.getRecords()
            .filter({ $0.isNotificationOn })
            .count == numberOfTasks else { return false }
        return true
    }
    
    func initialOrderinPicker() -> ([(row: Int, component: Int)]) {
        var items = [(row: Int, component: Int)]()
        items.append((row: STMOrderingMannerEnum.getStored().rawValue, component: 1))
        items.append((row: STMOrderingTypeEnum.getStored().rawValue, component: 0))
        return items
    }
    
    func updateOrdering(with row: Int, component: Int) {
        component == 0
            ? STMOrderingTypeEnum.manageOrdering(with: row)
            : STMOrderingMannerEnum.manageOrdering(with: row)
    }
}
