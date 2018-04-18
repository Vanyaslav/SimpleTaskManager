//
//  UNNotificationExtention.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation
import UserNotifications
//
private let center = UNUserNotificationCenter.current()
//
extension UNNotification {
    //
    public static func createNotification(from task:STMRecord) {
        //
        let content = UNMutableNotificationContent()
            content.body = (task.detail?.taskDescription!)!
            content.title = task.taskTitle!
        //
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: task.taskDueDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: task.id!.uuidString, content: content, trigger: trigger)
        //
        center.add(request, withCompletionHandler: { error in
            
        })
    }
    //
    public static func cancelNotification(with id:UUID) {
        center.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
    //
    public static func cancelAllNotifications() {
        center.removeAllPendingNotificationRequests()
    }
}
