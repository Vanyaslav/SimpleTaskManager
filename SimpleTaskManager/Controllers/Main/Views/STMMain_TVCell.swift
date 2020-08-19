//
//  STMMain_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
///
class STMMain_TVCell: STMConfirmButton_TVCell {
    @IBOutlet var titelLabel: UILabel!
    @IBOutlet var dueDateLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        formatButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //
    override var taskRecord: STMRecord? {
        didSet {
            titelLabel.text = taskRecord?.taskTitle
            dueDateLabel.text = taskRecord?.taskDueDate?.getString(with: .long)
        }
    }
}
