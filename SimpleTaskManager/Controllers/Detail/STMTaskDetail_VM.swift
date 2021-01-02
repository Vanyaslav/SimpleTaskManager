//
//  STMTaskDetail_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

extension STMTaskDetail_VM {
    var minTitleLength: Int { 2 }
}

class STMTaskDetail_VM {
    private let task: STMRecord?
    private let dataService: STMDataService
    
    init(dataService: STMDataService, task: STMRecord? = nil) {
        self.task = task
        self.dataService = dataService
        if nil != task {
            // editing mode
            initModel(with: task!)
        }
        // default behaviour is adding mode
    }
    
    var isEditing: Bool { return nil != task }
    var hasBeenUpdated = false
    lazy var taskCategories = dataService.getAllCategories()
    var taskTitle: String? {
        didSet {
            hasBeenUpdated = true
        }
    }
    var rowForCategory: Int {
        STMCategory.rowForCategory(with: taskCategory) ?? 0
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
    var taskNotificationStatus = false {
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
    private var isEligable: Bool {
        guard let title = taskTitle,
            title.count > minTitleLength else { return false }
        return true
    }
    
    func manageTask() {
        if let task = task {
            dataService.updateTaskStatus(task, status: !task.isFinished)
        }
    }
    
    func addNewTask() -> Bool {
        guard isEligable else { return false }
        dataService.appendNewTask(with: taskTitle!,
                                  category: taskCategory,
                                  date: taskDueDate,
                                  description: taskDesription,
                                  isNotified: taskNotificationStatus)
        return true
    }
    
    func editTask() -> Bool {
        guard let task = self.task,
            hasBeenUpdated,
            isEligable else { return false }
        dataService.updateTask(with: task,
                               title: taskTitle!,
                               category: taskCategory,
                               date: taskDueDate,
                               description: taskDesription,
                               isNotified: taskNotificationStatus,
                               status: taskStatus)
        return true
    }
    
    func updateCategory(with index: Int) {
        taskCategory = taskCategories[index]
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
