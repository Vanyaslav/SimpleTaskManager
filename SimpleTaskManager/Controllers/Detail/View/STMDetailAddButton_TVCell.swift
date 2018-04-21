//
//  STMAddButton_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

///
class STMDetailAddButton_TVCell: STMButton_TVCell {
    //
    weak var delegate: STMStoreDataDelegate?
    ///
    override func awakeFromNib() {
        super.awakeFromNib()
        //
        manageButton.setTitle("Add New Task", for: .normal)
        manageButton.addTarget(self, action: #selector(manageTask), for: .touchUpInside)
    }
    ///
    @objc func manageTask() {
        delegate?.saveTask()
    }
}
