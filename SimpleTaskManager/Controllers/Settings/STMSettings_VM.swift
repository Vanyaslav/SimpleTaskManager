//
//  STMSettings_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 23/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

class STMSettings_VM {
    let dataService: STMDataService

    init(dataService: STMDataService) {
        self.dataService = dataService
    }
    
    var numberOfTasks: Int {
        dataService.getRecords().count
    }
    
    var numberOfPickerComponents: Int {
        STMOrderingTypeEnum.allCases.count
    }
    
    var numberOfPickerRows: Int {
        STMOrderingMannerEnum.allCases.count
    }
    
    var initialNotificationState: Bool {
        guard dataService.getRecords()
            .filter({ $0.isNotificationOn })
            .count == numberOfTasks else { return false }
        return true
    }
    
    var initialPickerValues: [(row: Int, component: Int)] {
        var items = [(row: Int, component: Int)]()
        items.append((row: dataService.getOrderingManner(), component: 1))
        items.append((row: dataService.getOrderingType(), component: 0))
        return items
    }
    
    func notificationsChanged(_ status: Bool) {
        dataService.updateGlobalNotification(with: status)
    }
    
    func updateOrdering(with row: Int, component: Int) {
        component == 0
            ? dataService.storeOrderingType(with: row)
            : dataService.storeOrderingManner(with: row)
    }
    
    func loadTitles(with row: Int, component: Int) -> String? {
        component == 0
            ? STMOrderingTypeEnum.init(rawValue: row)?.title
            : STMOrderingMannerEnum.init(rawValue: row)?.title
    }
}
