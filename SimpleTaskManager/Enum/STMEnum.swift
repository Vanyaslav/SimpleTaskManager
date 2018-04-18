//
//  STMEnum.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation

//
enum STMTaskAction {
    // create
    case addNewTask(titel:String, category:STMCategory, dueDate:Date, description:String)
    // update
    case edit(task:STMRecord)
    // destroy
    case deleteTask(id:UUID)
    //
    func manageTask() {
        //
        switch self {
        case .addNewTask(let title, let category, let dueDate, let description):
            STMRecord.createTask(with: title, category: category, dueDate: dueDate, description: description)
        case .edit(task: let task):
            STMRecord.updateTask(with: task.id!, title: task.taskTitle, category: task.taskCategory, dueDate: task.taskDueDate, isFinished: task.isFinished)
        case .deleteTask(let id):
            STMRecord.deleteTask(with: id)
        }
    }
}
//
enum STMFinishTask {
    // finish
    case completeTask
    // unfinish
    case incompleteTask
    //
    func manageTask(with id: UUID) {
        switch self {
        case .completeTask: STMRecord.manageTaskStatus(with: id, isFinished: true)
        case .incompleteTask: STMRecord.manageTaskStatus(with: id, isFinished: false)
        }
    }
    //
    var labelTitle:String {
        switch self {
        case .incompleteTask:     return "Undo Finish!"
        case .completeTask:       return "Finish Task!"
        }
    }
}
