//
//  ColorPickerDataDelegate.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

@objc class ColorPickerDelegate: NSObject, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: 85, height: 25))
        view.backgroundColor = UIColor.standardColorList[row]
        return view
    }
}

//
@objc class ColorPickerData: NSObject, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        UIColor.standardColorList.count
    }
}
