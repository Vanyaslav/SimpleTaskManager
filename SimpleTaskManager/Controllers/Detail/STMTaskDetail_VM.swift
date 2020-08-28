//
//  STMTaskDetail_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

class STMTaskDetail_VM {
    var task: STMRecord?
    
    init(task: STMRecord? = nil) {
        self.task = task
        if nil != task {
            initModel(with: task!)
        }
    }
    
    var hasBeenUpdated = false
    
    var taskTitle: String? {
        didSet {
            hasBeenUpdated = true
        }
    }
    var taskCategory = STMCategory.allCategories[0] {
        didSet {
            hasBeenUpdated = true
        }
    }
    var taskDueDate = Date() {
        didSet {
            hasBeenUpdated = true
        }
    }
    var taskDesription: String = "" {
        didSet {
            hasBeenUpdated = true
        }
    }
    var taskNotificationStatus = false  {
        didSet {
            hasBeenUpdated = true
        }
    }
    var taskStatus = false {
        didSet {
            hasBeenUpdated = true
        }
    }
    ///
    var isEligable: Bool {
        guard let title = taskTitle, title.count > 2 else {
            return false
        }
        return true
    }
    
    func manageTask() {
        if let task = task {
            STMRecord.manageTaskStatus(with: task, isFinished: !task.isFinished)
        }
    }
    
    func addNewTask() -> Bool {
        guard isEligable else { return false }
        STMRecord.createTask(with: taskTitle!,
                             category: taskCategory,
                             dueDate: taskDueDate,
                             description: taskDesription,
                             isNotified: taskNotificationStatus)
        return true
    }
    
    func editTask() -> Bool  {
        guard let task = self.task, hasBeenUpdated else { return false }
        STMRecord.updateTask(with: task.id!,
                             title: taskTitle!,
                             category: taskCategory,
                             dueDate: taskDueDate,
                             description: taskDesription)

        STMRecord.updateTaskNotification(with: task, isNotified: taskNotificationStatus)
        STMRecord.manageTaskStatus(with: task, isFinished: taskStatus)
        
        return true
    }
    
    private func initModel(with task: STMRecord) {
        taskTitle = task.taskTitle
        taskCategory = task.taskCategory!
        taskDueDate = task.taskDueDate!
        taskDesription = task.taskDescription!
        taskNotificationStatus = task.isNotificationOn
        taskStatus = task.isFinished
    }
}
