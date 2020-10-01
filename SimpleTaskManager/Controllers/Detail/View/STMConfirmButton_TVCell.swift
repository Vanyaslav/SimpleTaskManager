//
//  STMConfirmButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 27/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit


class STMConfirmButton_TVCell: STMButton_TVCell, STMFormatState {
    private var viewModel: STMTaskDetail_VM!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        formatManageButton()
    }
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        
        manageButton.addTarget(self,
                               action: #selector(manageTask),
                               for: .touchUpInside)
            
        if viewModel.isEditing {
            manageButton.isSelected = viewModel.taskStatus
        }
    }
    ///
    @objc func manageTask() {
        manageButton.isSelected = !manageButton.isSelected
        viewModel.manageTask()
    }
}
