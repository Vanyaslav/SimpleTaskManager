//
//  STMDetail_Title_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

extension STMDetailTaskTitle_TVCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.taskTitle = textField.text
    }
}

class STMDetailTaskTitle_TVCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    
    private var viewModel: STMTaskDetail_VM!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        textField.text = viewModel.taskTitle
        textField.delegate = self
    }
}
