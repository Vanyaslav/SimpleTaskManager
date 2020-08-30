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
    
    var categoryTitle = ""
    var categoryColor = UIColor.standardColorList[0]
    
    private var isEligible: Bool {
        return categoryTitle.count > minTitleLegth
    }

    init(dataService: STMDataService) {
        self.dataService = dataService
    }
    
    func saveCategory() -> Bool {
        guard isEligible else { return false }
        dataService.saveCategory(with: categoryTitle, color: categoryColor)
        return true
    }
}
