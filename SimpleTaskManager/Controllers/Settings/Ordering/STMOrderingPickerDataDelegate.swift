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
        STMOrderingType.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        STMOrderingManner.allCases.count
    }
}
///
class STMOrderingPickerDelegate: NSObject, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        label.text = component == 0
            ? STMOrderingType.getTitle(row: row)
            : STMOrderingManner.getTitle(row: row)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        component == 0
            ? STMOrderingType.manageOrdering(with: row)
            : STMOrderingManner.manageOrdering(with: row)
    }
}
