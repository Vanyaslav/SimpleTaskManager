//
//  STMOrderingPickerDataDelegate.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

///
class STMOrderingPickerData: NSObject, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        STMOrderingTypeEnum.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        STMOrderingMannerEnum.allCases.count
    }
}
///
class STMOrderingPickerDelegate: NSObject, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        label.text = component == 0
            ? STMOrderingTypeEnum.getTitle(row: row)
            : STMOrderingMannerEnum.getTitle(row: row)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        component == 0
            ? STMOrderingTypeEnum.manageOrdering(with: row)
            : STMOrderingMannerEnum.manageOrdering(with: row)
    }
}
