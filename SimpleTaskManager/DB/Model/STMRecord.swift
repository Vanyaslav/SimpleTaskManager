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
    //
    public static func getAllTasks() -> [STMRecord] {
        guard let tasks = STMRecord.mr_findAll() as? [STMRecord] else {
            return []
        }
        return tasks
    }
    //
    public static func getTask(with theID:UUID) -> STMRecord? {
        return STMRecord.getAllTasks().filter({ record in
             record.id == theID
        }).first
    }
    //
    public static func createTask(with title:String, category:STMCategory, dueDate:Date, description: String) {
        //
        MagicalRecord.save(blockAndWait: { context in
            if let theRecord = STMRecord.mr_createEntity(in: context) {
                theRecord.id = UUID()
                theRecord.taskTitle = title
                theRecord.taskCategory = category
                theRecord.taskDueDate = dueDate
                theRecord.taskCreationDate = Date(timeIntervalSinceNow: 0)
                //
                STMRecordDetail.createTaskDetail(with: description, isNotified: false)
            }
        })
    }
    //
    public static func updateTask(with id:UUID, title:String?, category:STMCategory?, dueDate:Date?, isFinished:Bool) {
        //
        if let theRecord = getRecord(by: id) {
            //
            MagicalRecord.save(blockAndWait: { context in
                let localRecord = theRecord.mr_(in: context)
                localRecord?.taskTitle = title
                localRecord?.taskCategory = category
                localRecord?.taskDueDate = dueDate
                localRecord?.isFinished = isFinished
            })
        }
    }
    //
    public static func deleteTask(with id:UUID) {
        if let theRecord = getRecord(by: id)  {
            if theRecord.mr_deleteEntity() {
                
            }
        }
    }
    //
    public static func manageAllTaskNotification(isOn: Bool = true) {
        if isOn {
            _ = STMRecord.getAllTasks().map({ task in
                STMRecord.manageTaskNotification(with: task.id!, isNotified: true)
                //
                UNNotification.createNotification(from: task)
            })
            
        } else {
            //
            _ = STMRecord.getAllTasks().map({ task in
                STMRecord.manageTaskNotification(with: task.id!, isNotified: false)
            })
            //
            UNNotification.cancelAllNotifications()
        }
    }
    //
    
    //
    public static func manageTaskNotification(with id:UUID, isNotified:Bool) {
        //
        if let theRecord = getRecord(by: id) {
            //
            MagicalRecord.save(blockAndWait: { context in
                let localRecord = theRecord.mr_(in: context)
                localRecord?.detail?.isNotificationOn = isNotified
            })
        }
        //
        if isNotified {
            UNNotification.createNotification(from: STMRecord.getTask(with: id)!)
        } else {
            UNNotification.cancelNotification(with: id)
        }
    }
    //
    public static func manageTaskStatus(with id:UUID, isFinished:Bool) {
        //
        if let theRecord = getRecord(by: id) {
            //
            MagicalRecord.save(blockAndWait: { context in
                let localRecord = theRecord.mr_(in: context)
                localRecord?.isFinished = isFinished
            })
        }
    }
    //
    private static func getRecord(by id:UUID) -> STMRecord? {
        return STMRecord.mr_findFirst(byAttribute: "id", withValue: id)
    }
}
