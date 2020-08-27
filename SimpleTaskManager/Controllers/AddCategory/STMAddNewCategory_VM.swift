//
//  STMAddNewCategory_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 27/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

class STMAddNewCategory_VM {
    func saveCategory(with title: String, color: UIColor) {
        STMCategory.createTaskCategory(with: title, color: color)
    }
}
