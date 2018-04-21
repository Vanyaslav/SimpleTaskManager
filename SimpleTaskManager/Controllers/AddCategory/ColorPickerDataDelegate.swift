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
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let theView = UILabel(frame: CGRect(x: 0, y: 0, width: 85, height: 25))
        theView.backgroundColor = UIColor.standardColorList()[row]
        
        return theView
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
