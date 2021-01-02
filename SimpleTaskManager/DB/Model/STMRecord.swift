//
//  STMRecord.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation
import MagicalRecord
import UserNotifications
//
extension STMRecord {
    public static func getAllTasks(with key: Int? = nil, manner: Int? = nil) -> [STMRecord] {
        guard let key  = key,
              let manner = manner else { guard let data = STMRecord.mr_findAll() as? [STMRecord] else { return [] } ; return data }
        guard let storedManner = STMOrderingMannerEnum(rawValue: manner)?
                .actionBool,
              let typeTitle = STMOrderingTypeEnum(rawValue: key)?
                .managingParameter(),
              let tasks = STMRecord
            .mr_findAllSorted(by: typeTitle,
                              ascending: storedManner) as? [STMRecord] else {
            return []
        }
        
        return tasks
    }

    public static func createTask(with title: String,
                                  category: STMCategory,
                                  dueDate: Date,
                                  description: String,
                                  newId: UUID,
                                  isNotified: Bool) {
        MagicalRecord.save(blockAndWait: { context in
            if let theRecord = STMRecord.mr_createEntity(in: context) {
                theRecord.id = newId
                theRecord.taskTitle = title
                theRecord.taskDueDate = dueDate
                theRecord.taskCreationDate = Date()
                theRecord.isFinished = false
                theRecord.taskDescription = description
                theRecord.isNotificationOn = isNotified
                theRecord.taskCategory = (context.object(with: category.objectID) as! STMCategory)
            }
        })
    }

    public static func updateTask(with id: UUID,
                                  title: String?,
                                  category: STMCategory?,
                                  dueDate: Date?,
                                  description: String?,
                                  isNofitied: Bool?) {
        if let record = getRecord(by:id) {
            MagicalRecord.save(blockAndWait: { context in
                guard let localRecord = record.mr_(in: context) else { return }
                if let title = title {
                    localRecord.taskTitle = title
                }
                if let category = category {
                    localRecord.taskCategory = (context.object(with: category.objectID) as! STMCategory)
                }
                if let date = dueDate {
                    localRecord.taskDueDate = date
                }
                if let description = description {
                    localRecord.taskDescription = description
                }
                if let notified = isNofitied {
                    localRecord.isNotificationOn = notified
                }
            })
        }
    }
    
    public static func deleteTask(with id: UUID) {
        if let theRecord = getRecord(by: id) {
            MagicalRecord.save(blockAndWait: { context in
                if theRecord.mr_deleteEntity(in: context) {}
            })
        }
    }
    
    public static func updateAllTaskNotification(isOn: Bool = true) {
        STMRecord.getAllTasks().forEach({ task in
            STMRecord.updateTaskNotification(with: task, isNotified: isOn)
        })
    }
    
    public static func updateTaskNotification(with task: STMRecord, isNotified: Bool) {
        MagicalRecord.save(blockAndWait: { context in
            let localRecord = task.mr_(in:context)
            localRecord?.isNotificationOn = isNotified
        })
    }
    
    public static func manageTaskStatus(with task: STMRecord, isFinished: Bool) {
        if task.isFinished != isFinished {
            MagicalRecord.save(blockAndWait: { context in
                let localRecord = task.mr_(in: context)
                localRecord?.isFinished = isFinished
            })
        }
    }
    
    private static func getRecord(by id: UUID) -> STMRecord? {
        return STMRecord.mr_findFirst(byAttribute: "id", withValue: id)
    }
}
