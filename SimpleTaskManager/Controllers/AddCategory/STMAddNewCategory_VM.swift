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
    
    private var categoryTitle = ""
    private var categoryColor = UIColor.standardColorList[0]
    
    var isEligible: Bool { return categoryTitle.count > minTitleLegth }

    init(dataService: STMDataService) {
        self.dataService = dataService
    }
    
    func updateCategory(with title: String) {
        categoryTitle = title
    }
    
    func updateCategory(with color: UIColor) {
        categoryColor = color
    }
    
    func saveCategory() {
        dataService.saveCategory(with: categoryTitle, color: categoryColor)
    }
}
