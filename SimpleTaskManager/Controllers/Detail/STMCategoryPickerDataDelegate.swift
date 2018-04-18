//
//  STMCategoryPickerDataDelegate.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
//
class STMCategoryPicker: NSObject {
    //
    let taskCategories: [STMCategory] = STMCategory.mr_findAll() as? [STMCategory] ?? []
}
//
class STMCategoryPickerDelegate: STMCategoryPicker, UIPickerViewDelegate {
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taskCategories[row].title!
    }
}
//
class STMCategoryPickerData: STMCategoryPicker, UIPickerViewDataSource {
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskCategories.count
    }
}
