//
//  STMAddButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

///
class STMDetailAddButton_TVCell: UITableViewCell {
    @IBOutlet weak var manageButton: UIButton!
    
    private var viewModel: STMTaskDetail_VM!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        manageButton.addTarget(self,
                               action: #selector(manageTask),
                               for: .touchUpInside)
    }
    ///
    @objc func manageTask() {
        viewModel.addNewTask()
    }
}
