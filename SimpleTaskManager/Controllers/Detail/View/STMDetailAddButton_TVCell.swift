//
//  STMAddButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

//
protocol STMDetailAddButton_TVCellDelegate: class {
    func processedTask(with result: Bool)
}
///
class STMDetailAddButton_TVCell: UITableViewCell {
    @IBOutlet weak var manageButton: UIButton!
    
    weak var delagate: STMDetailAddButton_TVCellDelegate? = nil
    
    private var viewModel: STMTaskDetail_VM!
    
    func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
        manageButton.addTarget(self,
                               action: #selector(manageTask),
                               for: .touchUpInside)
    }
    ///
    @objc func manageTask() {
        delagate?.processedTask(with: viewModel.addNewTask())
    }
}
