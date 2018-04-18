//
//  STMDefaults.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation
import UIKit
import MagicalRecord
//
typealias STMCategoryType = [String: UIColor]
//
struct STMDefault {
    // 4 defaults categories
    static let categories:STMCategoryType = ["work":.blue,
                                             "excersise":.green,
                                             "meeting":.red,
                                             "other":.brown]
    // default storage name
    static let storageName = "STMTest"
    //
    struct font {
        //
        static let labelMain = "KohinoorBangla-Regular"
        static let labelMainSize: CGFloat = 18
        static let labelMinorSize: CGFloat = 15
        //
        static let buttonMainSize: CGFloat = 24
    }
    //
    static func initDefaults() {
        //
        if let font = UIFont(name: font.labelMain, size: font.labelMainSize) {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font:font]
        }
        
        // init just for the first run
        if STMCategory.mr_findAll()?.count == 0 {
            //
            _ = STMDefault.categories.map{ (title, color) in
                STMCategory.createTaskCategory(with: title, color: color)
            }
        }
    }
}
//
protocol STMPersistantProtocol {
    //
    func initPersinstantStore()
    //
    func deinitPersinstantStore()
}
// default implementation
extension STMPersistantProtocol {
    //
    func initPersinstantStore() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: STMDefault.storageName)
        //
        STMDefault.initDefaults()
    }
    //
    func deinitPersinstantStore() {
        MagicalRecord.cleanUp()
    }
}
