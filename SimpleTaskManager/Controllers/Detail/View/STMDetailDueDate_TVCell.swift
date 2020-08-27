//
//  STMDetailDueDate_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMDetailDueDate_TVCell: UITableViewCell {
    private var viewModel: STMTaskDetail_VM!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        datePicker.setDate(viewModel.taskDueDate, animated: true)
        datePicker.addTarget(self,
                             action: #selector(STMDetailDueDate_TVCell.pickerChangedDate(sender:)),
                             for: .valueChanged)
    }
    
    @objc func pickerChangedDate(sender: UIDatePicker) {
        viewModel.taskDueDate = sender.date
    }
}
