//
//  STMDataService.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 29/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

class STMDataService {
    func appendNewTask(with title: String,
                       category: STMCategory,
                       date: Date,
                       description: String,
                       isNotified: Bool) {
        STMRecord.createTask(with: title,
                             category: category,
                             dueDate: date,
                             description: description,
                             isNotified: isNotified)
    }
    
    func updateTask(with task: STMRecord,
                    title: String,
                    category: STMCategory,
                    date: Date,
                    description: String,
                    isNotified: Bool,
                    status: Bool) {
        STMRecord.updateTask(with: task.id!,
                             title: title,
                             category: category,
                             dueDate: date,
                             description: description)
        STMRecord.updateTaskNotification(with: task, isNotified: isNotified)
        STMRecord.manageTaskStatus(with: task, isFinished: status)
    }
    
    func updateTaskStatus(_ task: STMRecord, status: Bool) {
        STMRecord.manageTaskStatus(with: task, isFinished: status)
    }
    
    func getRecords(_ finished: Bool? = nil) -> [STMRecord] {
        guard let finished = finished else { return STMRecord.getAllTasks() }
        return STMRecord.getAllTasks(completed: finished)
    }
    
    func deleteRecord(with id: UUID) {
        STMRecord.deleteTask(with: id)
    }
    
    func manageRecord(_ record: STMRecord, with status: Bool) {
        STMRecord.manageTaskStatus(with: record, isFinished: !record.isFinished)
    }
    
    func updateGlobalNotification(with status: Bool){
        STMRecord.updateAllTaskNotification(isOn: status)
    }
    //
    func saveCategory(with title: String, color: UIColor) {
        STMCategory.createTaskCategory(with: title, color: color)
    }
}
