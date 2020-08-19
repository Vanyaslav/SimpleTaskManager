//
//  STMTaskDetail_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

class STMTaskDetail_VMNew {
    var task: STMRecord?
    
    init(task: STMRecord?) {
        self.task = task
        if nil != task {
            initModel(with: task!)
        }
    }
    
    var hasBeenUpdated = false
    var taskTitle: String = ""
    var taskCategory = STMCategory.allCategories[0]
    var taskDueDate = Date()
    var taskDesription: String = ""
    var taskNotificationStatus = false
    var taskStatus = false
    ///
    var isEligable: Bool {
        guard taskTitle.count > 2 else {
            return false
        }
        return true
    }
    
    func addNewTask() -> Bool {
        guard isEligable else { return false }
        STMRecord.createTask(with: taskTitle,
                             category: taskCategory,
                             dueDate: taskDueDate,
                             description: taskDesription,
                             isNotified: taskNotificationStatus)
        return true
    }
    
    func editTask() {
        guard let task = self.task else { return }
        STMRecord.updateTask(with: task.id!,
                             title: taskTitle,
                             category: taskCategory,
                             dueDate: taskDueDate,
                             description: taskDesription)

        STMRecord.updateTaskNotification(with: task, isNotified: taskNotificationStatus)
        STMRecord.manageTaskStatus(with: task, isFinished: taskStatus)
    }
    
    func updateModel(with type: STMTaskDetailEnum, value: AnyObject) {
        switch type {
        case .title: taskTitle = (value as! String)
        case .category: taskCategory = (value as! STMCategory)
        case .dueDate: taskDueDate = (value as! Date)
        case .description: taskDesription = (value as! String)
        case .status: taskStatus = (value as! Bool)
        case .notification: taskNotificationStatus = (value as! Bool)
        }
        
        self.hasBeenUpdated = true
    }
    
    private func initModel(with task: STMRecord) {
        taskTitle = task.taskTitle ?? ""
        taskCategory = task.taskCategory!
        taskDueDate = task.taskDueDate!
        taskDesription = task.taskDescription!
        taskNotificationStatus = task.isNotificationOn
        taskStatus = task.isFinished
    }
}
