//
//  UNNotificationExtention.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

private let center = UNUserNotificationCenter.current()

extension UNNotification {
    public static func makeAuthorizationRequest(with delegate: UNUserNotificationCenterDelegate) {

        center.delegate = delegate
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        }
    }

    public static func createNotification(from task:STMRecord) {
        cancelNotification(with: task.id!)
        
        let content = UNMutableNotificationContent()
        if let theDescription = task.taskDescription {
            content.body = theDescription
        }
        
        content.title = task.taskTitle!
        content.sound = UNNotificationSound.default
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day, .hour, .minute], from: task.taskDueDate!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: task.id!.uuidString, content: content, trigger: trigger)
        
        center.add(request,
                   withCompletionHandler: { error in
            
        })
    }
    
    public static func cancelNotification(with id:UUID) {
        center.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
    
    public static func cancelAllNotifications() {
        center.removeAllPendingNotificationRequests()
    }
}
