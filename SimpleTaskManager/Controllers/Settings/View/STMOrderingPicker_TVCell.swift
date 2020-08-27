//
//  STMOrderingPicker_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMOrderingPicker_TVCell: UITableViewCell {
    @IBOutlet weak var picker: UIPickerView!
    
    private var viewModel: STMSettings_VM!
    
    func configure(with viewModel: STMSettings_VM) {
        self.viewModel = viewModel
        
        viewModel.initialOrderinPicker()
            .forEach{ picker.selectRow($0.row,
                                       inComponent: $0.component,
                                       animated: true) }
    }
}
