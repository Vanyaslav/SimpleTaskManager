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
    public static func getAllTasks(completed:Bool) -> [STMRecord] {
        let tasks = getAllTasks()
        //
        let filteredTasks = tasks.filter({ task in
            task.isFinished == completed
        })
        
        return filteredTasks
    }
    //
    public static func getAllTasks() -> [STMRecord] {
        //
        let theType = STMOrderingType.getOrderVariable()
        let theManner = STMOrderingManner.getStored() == .ascending ? true:false
        //
        guard let tasks = STMRecord.mr_findAllSorted(by: theType, ascending: theManner) as? [STMRecord] else {
            return []
        }
        
        return tasks
    }
    //
    public static func createTask(with title:String, category:STMCategory, dueDate:Date, description:String, isNotified:Bool) {
        //
        MagicalRecord.save(blockAndWait: { context in
            if let theRecord = STMRecord.mr_createEntity(in: context) {
                theRecord.id = UUID()
                theRecord.taskTitle = title
                theRecord.taskDueDate = dueDate
                theRecord.taskCreationDate = Date(timeIntervalSinceNow: 0)
                theRecord.isFinished = false
                theRecord.taskDescription = description
                theRecord.taskCategory = (context.object(with: category.objectID) as! STMCategory)
            }
        })
    }
    //
    public static func updateTask(with id:UUID, title:String, category:STMCategory, dueDate:Date, description:String) {
        //
        if let theRecord = getRecord(by:id) {
            //
            MagicalRecord.save(blockAndWait: { context in
                let localRecord = theRecord.mr_(in: context)
                //
                localRecord?.taskTitle = title
                localRecord?.taskCategory = (context.object(with:category.objectID) as! STMCategory)
                localRecord?.taskDueDate = dueDate
                localRecord?.taskDescription = description
            })
        }
    }
    //
    public static func deleteTask(with id:UUID) {
        if let theRecord = getRecord(by: id)  {
            //
            MagicalRecord.save(blockAndWait: { context in
                if theRecord.mr_deleteEntity(in: context) {
                    
                }
            })
        }
    }
    //
    public static func manageAllTaskNotification(isOn: Bool = true) {
        _ = STMRecord.getAllTasks().map({ task in
            STMRecord.manageTaskNotification(with: task, isNotified: isOn)
            
        })
    }
    
    //
    public static func manageTaskNotification(with task:STMRecord, isNotified:Bool) {
        //
        if !task.isNotificationOn {
            //
            MagicalRecord.save(blockAndWait: { context in
                let localRecord = task.mr_(in:context)
                localRecord?.isNotificationOn = isNotified
            })
            //
            if isNotified {
                UNNotification.createNotification(from: STMRecord.getRecord(by: task.id!)!)
            } else {
                UNNotification.cancelNotification(with: task.id!)
            }
        }
    }
    //
    public static func manageTaskStatus(with task:STMRecord, isFinished:Bool) {
        //
        if task.isFinished != isFinished {
            //
            MagicalRecord.save(blockAndWait: { context in
                let localRecord = task.mr_(in: context)
                localRecord?.isFinished = isFinished
            })
        }
    }
    //
    private static func getRecord(by id:UUID) -> STMRecord? {
        return STMRecord.mr_findFirst(byAttribute: "id", withValue: id)
    }
}