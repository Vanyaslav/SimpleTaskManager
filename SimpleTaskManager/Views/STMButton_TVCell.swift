//
//  STMButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
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
// generic one
class STMButton_TVCell: UITableViewCell {
    @IBOutlet weak var manageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        formatButton()
    }
}
