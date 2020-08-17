//
//  STMTaskDetail_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation


class STMTaskDetail_VM {
    //
    var taskTitle: String = ""
    //
    var taskCategory = STMCategory.allCategories[0]
    //
    var taskDueDate = Date()
    //
    var taskDesription: String = ""
    //
    var taskNotificationStatus = false
    //
    var taskStatus = false
    ///
    var isEligable: Bool {
        guard taskTitle.count > 2 else {
            return false
        }
        return true
    }
    //
    func initModel(with task: STMRecord) {
        taskTitle = task.taskTitle ?? ""
        taskCategory = task.taskCategory!
        taskDueDate = task.taskDueDate!
        taskDesription = task.taskDescription!
        taskNotificationStatus = task.isNotificationOn
        taskStatus = task.isFinished
    }
}
