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

private let notificationCenter = UNUserNotificationCenter.current()

extension UNNotification {
    public static func makeAuthorizationRequest(with delegate: UNUserNotificationCenterDelegate) {
        notificationCenter.delegate = delegate
        notificationCenter
            .requestAuthorization(options: [.alert,
                                            .badge,
                                            .sound]) { (granted, error) in
        }
    }

    public static func createNotification(with title: String,
                                          description: String? = nil,
                                          dueDate: Date,
                                          id: UUID) {
        cancelNotification(with: id)
        
        let content = UNMutableNotificationContent()
        if let description = description {
            content.body = description
        }
        
        content.title = title
        content.sound = UNNotificationSound.default
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        
        let triggerDate = Calendar.current
            .dateComponents([.year,
                             .month,
                             .day,
                             .hour,
                             .minute], from: dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: id.uuidString,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
    public static func cancelNotification(with id: UUID) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
    
    public static func cancelAllNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
