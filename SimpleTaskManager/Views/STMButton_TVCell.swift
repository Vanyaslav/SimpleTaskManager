//
//  STMButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
// generic one
class STMButton_TVCell: UITableViewCell {
    @IBOutlet weak var manageButton: UIButton!
}
/// Used for main view cell and task detail cell as a base cell
class STMConfirmButton_TVCell: STMButton_TVCell {
    //
    var taskRecord: STMRecord? {
        didSet {
            formatButton()
        }
    }
    //
    weak var delegate: STMTaskList_TVC_Delegate? = nil
    //
    func formatButton() {
        manageButton.addTarget(self, action: #selector(manageTask), for: .touchUpInside)
        manageButton.isSelected = (taskRecord?.isFinished)!
    }
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        manageButton.setTitle(STMTaskStatusEnum.incompleteTask.labelTitle, for: .normal)
        manageButton.setTitle(STMTaskStatusEnum.completeTask.labelTitle, for: .selected)
    }
    ///
    @objc func manageTask() {
        (taskRecord?.isFinished)!
            ? STMTaskStatusEnum.incompleteTask.manageTask(with: taskRecord!)
            : STMTaskStatusEnum.completeTask.manageTask(with: taskRecord!)
        
        delegate?.reloadData()
    }
}
