//
//  STMDetailCategoty_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit


class STMDetailCategoty_TVCell: STMPicker_TVCell, UIPickerViewDelegate, UIPickerViewDataSource {
    //
    weak var delegate: STMRecordDetailProtocol?
    //
    let taskCategories = STMCategory.allCategories
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taskCategories[row].title!
    }
    //
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // delegate
        delegate?.updateDetailModel(with: .category, value: taskCategories[row])
    }
    
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskCategories.count
    }
}
