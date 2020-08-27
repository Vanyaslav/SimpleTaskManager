//
//  STMTaskDetailTextView_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

extension STMDetailTextView_TVCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.taskDesription = textView.text
    }
}

class STMDetailTextView_TVCell: UITableViewCell {
    private var viewModel: STMTaskDetail_VM!
    
    @IBOutlet weak var taskDescription: UITextView!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        taskDescription.text = viewModel.taskDesription
        taskDescription.delegate = self
    }
}
