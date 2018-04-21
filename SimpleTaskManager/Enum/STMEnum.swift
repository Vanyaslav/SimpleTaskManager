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
    case addNew(titel:String, category:STMCategory, dueDate:Date, description:String, isNotified:Bool)
    // update
    case edit(id:UUID, titel:String, category:STMCategory, dueDate:Date, description:String)
    // destroy
    case deleteTask(id:UUID)
    //
    func manageTask() {
        //
        switch self {
        case .addNew(let title, let category, let dueDate, let description, let isNotified):
            STMRecord.createTask(with: title, category: category, dueDate: dueDate, description: description, isNotified:isNotified)
            
        case .edit(let id, let title, let category, let dueDate, let description):
            STMRecord.updateTask(with: id, title: title, category: category, dueDate: dueDate, description: description)
        case .deleteTask(let id):
            STMRecord.deleteTask(with: id)
        }
    }
}
//
enum STMTaskStatus {
    // finish
    case completeTask
    // unfinish
    case incompleteTask
    //
    func manageTask(with record:STMRecord) {
        switch self {
        case .completeTask: STMRecord.manageTaskStatus(with: record, isFinished: true)
        case .incompleteTask: STMRecord.manageTaskStatus(with: record, isFinished: false)
        }
    }
    //
    var labelTitle:String {
        switch self {
        case .incompleteTask:     return "Finish Task!"
        case .completeTask:       return "Undo Finish!"
        }
    }
    //
    var tableHeaderTitle:String {
        switch self {
        case .incompleteTask:     return "Incompleted Tasks"
        case .completeTask:       return "Completed Tasks"
        }
    }
}
