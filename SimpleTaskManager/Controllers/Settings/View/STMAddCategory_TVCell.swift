//
//  STMAddCategory_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMAddCategory_TVCell: STMButton_TVCell {
    //
    let delegate: STMSettings_TVC_Delegate? = nil
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        manageButton.addTarget(self, action:#selector(pushViewAddNewCategory), for: .touchUpInside)
    }
    
    ///
    @objc func pushViewAddNewCategory() {
        delegate?.pushAddCategoryController()
    }
}
