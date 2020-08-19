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
    
    func reloadRecords() {
        completedTasks = STMRecord.getAllTasks(completed: true)
        incompletedTasks = STMRecord.getAllTasks(completed: false)
    }
    
    func deleteRecords(in indexPath: IndexPath) {
            STMRecord.deleteTask(with: indexPath.section == 0
                ? incompletedTasks[indexPath.row].id!
                : completedTasks[indexPath.row].id!)
        reloadRecords()
    }
}
