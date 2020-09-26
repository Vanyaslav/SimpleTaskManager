//
//  STMMain_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
///
class STMMain_TVCell: STMButton_TVCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    weak var delegate: STMTaskList_TVCDelegate? = nil
    
    private var viewModel: STMTaskList_VM!
    
    private var indexPath: IndexPath!
    
    func configure(with viewModel: STMTaskList_VM, indexPath: IndexPath) {
        self.viewModel = viewModel
        self.indexPath = indexPath
        
        let task = viewModel.getRecord(with: indexPath)
        
        if let color = task.taskCategory?.backgroundColor {
            backgroundColor = UIColor(ciColor: CIColor(string: color))
                .withAlphaComponent(0.3)
        }
        titleLabel.text = task.taskTitle
        dueDateLabel.text = task.taskDueDate?.getString(with: .long)
        manageButton.isSelected = indexPath.section == 1
        
        manageButton.addTarget(self,
                               action: #selector(toggleTaskState),
                               for: .touchUpInside)
    }
    
    @objc func toggleTaskState() {
        manageButton.isSelected = !isSelected
        viewModel.manageTaskState(indexPath: indexPath)
        delegate?.reloadData()
    }
}
