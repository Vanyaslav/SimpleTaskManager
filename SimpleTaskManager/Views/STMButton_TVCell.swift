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
    //
    @IBOutlet weak var manageButton: UIButton!
}
/// Used for main view cell and task detail cell as a base cell
class STMConfirmButton_TVCell: STMButton_TVCell {
    //
    var theTaskRecord:STMRecord? {
        didSet {
            formatButton()
        }
    }
    //
    weak var delegate: STMTaskList_TVC_Delegate? = nil
    //
    internal func formatButton() {
        manageButton.addTarget(self, action:#selector(manageTask), for: .touchUpInside)
        manageButton.isSelected = (theTaskRecord?.isFinished)!
    }
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        manageButton.setTitle(STMTaskStatus.incompleteTask.labelTitle, for: .normal)
        manageButton.setTitle(STMTaskStatus.completeTask.labelTitle, for: .selected)
        //
    }
    ///
    @objc func manageTask() {
        //
        if (theTaskRecord?.isFinished)! {
            STMTaskStatus.incompleteTask.manageTask(with:theTaskRecord!)
        } else {
            STMTaskStatus.completeTask.manageTask(with:theTaskRecord!)
        }
        //
        delegate?.reloadData()
    }
}
