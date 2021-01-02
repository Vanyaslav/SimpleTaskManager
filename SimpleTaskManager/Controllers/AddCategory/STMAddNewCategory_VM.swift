//
//  STMAddNewCategory_VM.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 27/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

extension STMAddNewCategory_VM {
    var minTitleLength: Int { 2 }
}

class STMAddNewCategory_VM {
    // in
    func assignColor(with index: Int) {
        categoryColor = colors[index]
    }
    
    var categoryTitle = ""
    // out
    func getColor(with index: Int) -> UIColor {
        colors[index]
    }
    
    var numberOfColors: Int { colors.count }
    
    private
    var isEligible: Bool { return categoryTitle.count > minTitleLength }
    
    private
    let colors = UIColor.standardColorList
    
    private
    var categoryColor = UIColor.standardColorList[0]
    
    private
    let dataService: STMDataService

    init(dataService: STMDataService) {
        self.dataService = dataService
    }
    
    func saveCategory() -> Bool {
        guard isEligible else { return false }
        dataService.saveCategory(with: categoryTitle, color: categoryColor)
        return true
    }
}
