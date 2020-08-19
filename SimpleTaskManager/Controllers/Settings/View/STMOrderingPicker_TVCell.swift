//
//  STMOrderingPicker_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMOrderingPicker_TVCell: STMPicker_TVCell {
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // set ordering configuration
        self.thePicker.selectRow(STMOrderingManner.getStored().rawValue, inComponent: 1, animated: true)
        self.thePicker.selectRow(STMOrderingType.getStored().rawValue, inComponent: 0, animated: true)
    }
}
