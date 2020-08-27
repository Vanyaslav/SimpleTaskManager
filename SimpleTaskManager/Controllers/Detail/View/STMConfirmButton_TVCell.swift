//
//  STMConfirmButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 27/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit


class STMConfirmButton_TVCell: STMButton_TVCell {
    private var viewModel: STMTaskDetail_VM!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        manageButton.setTitle(STMTaskStatusEnum.incompleteTask.labelTitle,
                              for: .normal)
        manageButton.setTitle(STMTaskStatusEnum.completeTask.labelTitle,
                              for: .selected)
        assignAction()
        
        if let task = viewModel.task {
            manageButton.isSelected = task.isFinished
        }
    }

    func assignAction() {
        manageButton.addTarget(self,
                               action: #selector(manageTask),
                               for: .touchUpInside)
    }
    ///
    @objc func manageTask() {
        manageButton.isSelected = !isSelected
        viewModel.manageTask()
    }
}
