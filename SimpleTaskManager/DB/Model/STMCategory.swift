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

//
extension STMCategory {
    //
    public static func getAllCategories() -> [STMCategory] {
        return STMCategory.mr_findAll() as? [STMCategory] ?? []
    }
    //
    public static func createTaskCategory(with title:String, color:UIColor) {
        //
        MagicalRecord.save(blockAndWait: { context in
            let theRecord = STMCategory.mr_createEntity(in: context)
            theRecord?.title = title
            theRecord?.backgroundColor = color.coreImageColor.stringRepresentation
            
        })
    }
}
