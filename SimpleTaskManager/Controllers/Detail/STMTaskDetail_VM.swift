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
        if let task = task {
            // editing mode
            initModel(with: task)
        }
    }
    
    var isEditing: Bool { return nil != task }
    var didUpdate = false
    lazy var taskCategories = dataService.getAllCategories()
    
    var rowForCategory: Int {
        STMCategory.rowForCategory(with: taskCategory) ?? 0
    }
    
    var taskTitle: String? {
        didSet {
            didUpdate = taskTitle != task?.taskTitle
        }
    }
    var taskCategory = STMCategory.allCategories[0] {
        didSet {
            didUpdate = taskCategory != task?.taskCategory
        }
    }
    var taskDueDate = Date() {
        didSet {
            didUpdate = taskDueDate != task?.taskDueDate
        }
    }
    var taskDesription: String = "" {
        didSet {
            didUpdate = taskDesription != task?.taskDescription
        }
    }
    var taskNotificationStatus = false {
        didSet {
            didUpdate = taskNotificationStatus != task?.isNotificationOn
        }
    }
    var taskStatus = false {
        didSet {
            didUpdate = taskStatus != task?.isFinished
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
            dataService.manageRecord(task)
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
        guard let task = self.task, isEligable else { return false }
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
