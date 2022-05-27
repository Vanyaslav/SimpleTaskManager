//
//  STMTaskList_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 18/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

class STMTaskList_VM {
    private var completedTasks = [STMRecord]()
    private var incompletedTasks = [STMRecord]()
    
    var numberOfSections: Int {
        completedTasks.count + incompletedTasks.count > 0
            ? 2
            : 0
    }
    
    private let dataService: STMDataService

    var settingsViewModel: STMSettings_VM {
        STMSettings_VM(dataService: dataService)
    }
    
    init(dataService: STMDataService = STMDataService()) {
        self.dataService = dataService
    }

    func taskDetailViewModel(record: STMRecord?) -> STMTaskDetail_VM {
        STMTaskDetail_VM(dataService: dataService,
                         task: record)
    }
    
    func numberOfRows(in section: Int) -> Int {
        section == 0
            ? incompletedTasks.count
            : completedTasks.count
    }
    
    func tableHeaderTitle(in section: Int) -> String {
        section == 0
            ? STMTaskStatusEnum.incompleteTask.tableHeaderTitle
            : STMTaskStatusEnum.completeTask.tableHeaderTitle
    }
    
    func reloadRecords() {
        completedTasks = dataService.getRecords(finished: true)
        incompletedTasks = dataService.getRecords(finished: false)
    }
    
    func deleteRecords(in indexPath: IndexPath) {
        dataService.deleteRecord(getRecord(with: indexPath))
        reloadRecords()
    }
    
    func manageTaskState(indexPath: IndexPath) {
        dataService.manageRecord(getRecord(with: indexPath))
        reloadRecords()
    }
    
    func getRecord(with indexPath: IndexPath) -> STMRecord {
        indexPath.section == 0
            ? incompletedTasks[indexPath.row]
            : completedTasks[indexPath.row]
    }
}
