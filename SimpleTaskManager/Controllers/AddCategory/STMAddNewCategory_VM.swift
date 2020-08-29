//
//  STMAddNewCategory_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 27/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

class STMAddNewCategory_VM {
    let minTitleLegth = 2
    
    let dataService: STMDataService

    init(dataService: STMDataService) {
        self.dataService = dataService
    }
    
    func saveCategory(with title: String, color: UIColor) {
        dataService.saveCategory(with: title, color: color)
    }
}
