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
    let colors = UIColor.standardColorList
    
    var categoryTitle = ""
    private
    var categoryColor = UIColor.standardColorList[0]
    
    func assignColor(with index: Int) {
        categoryColor = colors[index]
    }
    
    func getColor(with index: Int) -> UIColor {
        colors[index]
    }
    
    private var isEligible: Bool {
        return categoryTitle.count > minTitleLength
    }
    
    private let dataService: STMDataService

    init(dataService: STMDataService) {
        self.dataService = dataService
    }
    
    func saveCategory() -> Bool {
        guard isEligible else { return false }
        dataService.saveCategory(with: categoryTitle, color: categoryColor)
        return true
    }
}
