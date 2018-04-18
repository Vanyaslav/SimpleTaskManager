//
//  STMButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
//
class STMButton_TVCell: UITableViewCell {
    //
    @IBOutlet var manageButton: UIButton!
}
/// Used for main view cell and task detail cell 
class STMConfirmButton_TVCell: STMButton_TVCell {
    // possibly using MVVM can bring very similar solution, but with structs on board might be less resource consumpting
    // default
    var theTaskRecord: STMRecord? {
        didSet {
            formatButton()
        }
    }
    //
    internal func formatButton() {
        manageButton.addTarget(self, action:#selector(manageTask), for: .touchUpInside)
        manageButton.isSelected = (theTaskRecord?.isFinished)! ? true : false
    }
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        manageButton.setTitle(STMFinishTask.incompleteTask.labelTitle, for: .normal)
        manageButton.setTitle(STMFinishTask.completeTask.labelTitle, for: .selected)
        //
    }
    ///
    @objc func manageTask() {
        //
        manageButton.isSelected = !manageButton.isSelected
        //
        if let task = theTaskRecord, let id = task.id {
            if task.isFinished {
                STMFinishTask.incompleteTask.manageTask(with: id)
            } else {
                STMFinishTask.completeTask.manageTask(with: id)
            }
        }
    }
}
