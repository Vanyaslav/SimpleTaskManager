//
//  STMDetailNotification_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMDetailNotification_TVCell: STMSwitch_TVCell {
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.isGlobal = false
    }
}