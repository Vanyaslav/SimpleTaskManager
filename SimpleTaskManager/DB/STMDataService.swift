//
//  STMDataService.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 29/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

extension STMDataService {
    func storeOrderingManner(with manner: Int) {
        orderingManner = manner
    }
    
    func storeOrderingType(with key: Int) {
        storageKey = key
    }
    
    func getOrderingManner() -> Int {
        orderingManner
    }
    
    func getOrderingType() -> Int {
        storageKey
    }
}

extension STMDataService {
    func manageNotification(with id: UUID,
                            title: String? = nil,
                            description: String? = nil,
                            dueDate: Date? = nil) {
        if let title = title, let date = dueDate {
            UNNotification.createNotification(with: title, description: description, dueDate: date, id: id)
        } else {
            UNNotification.cancelNotification(with: id)
        }
    }
}

extension STMDataService {
    func appendNewTask(with title: String,
                       category: STMCategory,
                       date: Date,
                       description: String,
                       isNotified: Bool) {
        
        let uuid = UUID()
        
        if isNotified {
            manageNotification(with: uuid,
                               title: title,
                               description: description,
                               dueDate: date)
        }
        
        STMRecord.createTask(with: title,
                             category: category,
                             dueDate: date,
                             description: description,
                             newId: uuid,
                             isNotified: isNotified)
    }
    
    func updateTask(with task: STMRecord,
                    title: String,
                    category: STMCategory,
                    date: Date,
                    description: String,
                    isNotified: Bool,
                    status: Bool) {
        
        manageNotification(with: task.id!,
                           title: isNotified ? title : nil,
                           description: description,
                           dueDate: isNotified ? date : nil)

        STMRecord.updateTask(with: task.id!,
                             title: title,
                             category: category,
                             dueDate: date,
                             description: description,
                             isNofitied: isNotified)
        manageRecord(task, status: status)
    }
    
    func getRecords(finished: Bool? = nil) -> [STMRecord] {
        let key = storageKey
        let manner = orderingManner
        let data = STMRecord.getAllTasks(with: key, manner: manner)
        guard let finished = finished else { return  data }
        return data.filter{ $0.isFinished == finished }
    }
    
    func deleteRecord(_ record: STMRecord) {
        guard let id = record.id else { debugPrint("No record to be deleted!") ; return }
        STMRecord.deleteTask(with: id)
    }
    
    func manageRecord(_ record: STMRecord, status: Bool? = nil) {
        STMRecord.manageTaskStatus(with: record, isFinished: status ?? !record.isFinished)
    }
    
    func updateGlobalNotification(with status: Bool) {
        STMRecord.updateAllTaskNotification(isOn: status)
    }
    //
    func saveCategory(with title: String, color: UIColor) {
        STMCategory.createTaskCategory(with: title, color: color)
    }
    
    func getAllCategories() -> [STMCategory] {
        STMCategory.allCategories
    }
}

class STMDataService {
    @LocalStorage("orderingManner", defaultValue: 0)
    private var orderingManner: Int
    
    @LocalStorage("storageKey", defaultValue: 0)
    private var storageKey: Int
}
