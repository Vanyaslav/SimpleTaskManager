//
//  STMConfirmButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 27/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

extension STMButton_TVCell {
    func formatButton() {
        manageButton.setTitle(STMTaskStatusEnum.incompleteTask.labelTitle,
                              for: .normal)
        manageButton.setTitle(STMTaskStatusEnum.completeTask.labelTitle,
                              for: .selected)
    }
}

class STMConfirmButton_TVCell: STMButton_TVCell {
    private var viewModel: STMTaskDetail_VM!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        
        manageButton.addTarget(self,
                               action: #selector(manageTask),
                               for: .touchUpInside)
            
        if viewModel.isEditing {
            manageButton.isSelected = viewModel.taskStatus
        }
        
        formatButton()
    }
    ///
    @objc func manageTask() {
        manageButton.isSelected = !manageButton.isSelected
        viewModel.manageTask()
    }
}
