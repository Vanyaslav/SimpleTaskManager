//
//  STMCategory.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation
import UIKit
import MagicalRecord


extension STMCategory {
    public static var allCategories: [STMCategory] {
        return STMCategory.mr_findAll() as? [STMCategory] ?? []
    }
    
    public static func createTaskCategory(with title: String, color: UIColor) {
        MagicalRecord.save(blockAndWait: { context in
            let record = STMCategory.mr_createEntity(in: context)
            record?.title = title
            record?.backgroundColor = color.coreImageColor.stringRepresentation
        })
    }
}
