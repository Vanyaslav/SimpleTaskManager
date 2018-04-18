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
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return STMOrderingType.numberOfTypes
    }
    //
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return STMOrderingManner.numberOfManners
    }
}
///
class STMOrderingPickerDelegate: NSObject, UIPickerViewDelegate {
    //
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch component {
//        case 0: return STMOrderingType.getTitle(row: row)
//        default: return STMOrderingManner.getTitle(row: row)
//        }
//    }
    //
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 185, height: 25))
        label.textAlignment = .center
        label.textColor = .blue
        //
        switch component {
        case 0: label.text = STMOrderingType.getTitle(row: row)
        default: label.text =  STMOrderingManner.getTitle(row: row)
        }
        //
        return label
    }
    //
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: STMOrderingType.manageOrderingType(with: row)
        default: STMOrderingManner.manageOrderingManner(with: row)
        }
    }
}
