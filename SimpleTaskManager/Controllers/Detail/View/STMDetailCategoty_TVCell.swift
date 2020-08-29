//
//  STMDetailCategoty_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

extension STMDetailCategoty_TVCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        viewModel.updateCategory(with: row)
    }
}

extension STMDetailCategoty_TVCell: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        viewModel.taskCategories[row].title!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        viewModel.taskCategories.count
    }
}


class STMDetailCategoty_TVCell: UITableViewCell {
    @IBOutlet weak var picker: UIPickerView!
    
    private var viewModel: STMTaskDetail_VM!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        
        guard let category = viewModel
            .taskCategories
            .firstIndex(of: viewModel.taskCategory) else { return }
        
        self.picker.selectRow(category,
                              inComponent: 0,
                              animated: true)
    }
}
