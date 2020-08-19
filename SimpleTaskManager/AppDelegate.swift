//
//  AppDelegate.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
import UserNotifications

//
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,
                           .sound,
                           .badge])
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, STMPersistentProtocol {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        STMDefault.initDefaults()
        initPersinstentStore()
        UNNotification.makeAuthorizationRequest(with: self)
        
        if let nc = window?.rootViewController as? UINavigationController,
            let vc = nc.topViewController as? STMTaskList_TVC {
            vc.viewModel = STMTaskList_VM()
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        deinitPersinstentStore()
    }
}

