//
//  ColorPickerDataDelegate.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

//
@objc class ColorPickerDelegate: NSObject, UIPickerViewDelegate {
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UIColor.standardColorList()[row].convertToString()
    }
}

//
@objc class ColorPickerData: NSObject, UIPickerViewDataSource {
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIColor.standardColorList().count
    }
}
