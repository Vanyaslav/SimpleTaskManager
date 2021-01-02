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
    static let categories: STMCategoryType = ["Music":       .blue,
                                              "Girlfriend":  .green,
                                              "Education":   .red,
                                              "Customer":    .brown]
    // default storage name
    static let storageName = "STMTest"
    //
    struct font {
        static let labelMain = "KohinoorBangla-Regular"
        static let labelMainSize: CGFloat = 18
        static let labelMinorSize: CGFloat = 15
        static let buttonMainSize: CGFloat = 24
    }
    //
    static func initDefaults() {
        if let font = UIFont(name: font.labelMain, size: font.labelMainSize) {
            UIBarButtonItem.appearance()
                .setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
            UINavigationBar.appearance()
                .titleTextAttributes = [NSAttributedString.Key.font: font]
            UILabel.appearance()
                .font = font
            UILabel.appearance(whenContainedInInstancesOf: [UIButton.self])
                .font = font
        }
    }
}
//
protocol STMPersistentProtocol {
    func initPersinstentStore()
    func deinitPersinstentStore()
}
// default implementation
extension STMPersistentProtocol {
    func initPersinstentStore() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: STMDefault.storageName)
        //
        // init just for the first run
        if STMCategory.mr_findAll()?.count == 0 {
            STMDefault.categories.forEach(STMCategory.createTaskCategory)
        }
    }
    
    func deinitPersinstentStore() {
        MagicalRecord.cleanUp()
    }
}
