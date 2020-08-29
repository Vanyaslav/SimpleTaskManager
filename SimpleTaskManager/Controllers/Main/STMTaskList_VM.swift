//
//  STMTaskList_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 18/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

class STMTaskList_VM {
    var completedTasks = [STMRecord]()
    var incompletedTasks = [STMRecord]()
    
    var numberOfItems: Int {
        return completedTasks.count + incompletedTasks.count
    }
    
    let dataService: STMDataService
    
    init(dataService: STMDataService) {
        self.dataService = dataService
    }
    
    func reloadRecords() {
        completedTasks = dataService.getRecords(true)
        incompletedTasks = dataService.getRecords(false)
    }
    
    func deleteRecords(in indexPath: IndexPath) {
        guard let id = getRecord(with: indexPath).id else { return }
        dataService.deleteRecord(with: id)
        reloadRecords()
    }
    
    func manageTaskState(indexPath: IndexPath) {
        let record = getRecord(with: indexPath)
        dataService.manageRecord(record, with: !record.isFinished)
        reloadRecords()
    }
    
    private func getRecord(with indexPath: IndexPath) -> STMRecord {
        return indexPath.section == 0
            ? incompletedTasks[indexPath.row]
            : completedTasks[indexPath.row]
    }
}
