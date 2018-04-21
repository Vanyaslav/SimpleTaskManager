//
//  STMDetailDueDate_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMDetailDueDate_TVCell: UITableViewCell {
    //
    @IBOutlet weak var theDatePicker: UIDatePicker!
    //
    weak var delegate:RecordDetailUpdate?
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        theDatePicker.addTarget(self,
                                action: #selector(STMDetailDueDate_TVCell.pickerChangedDate(sender:)),
                                for: .valueChanged)
    }
    //
    @objc func pickerChangedDate(sender:UIDatePicker) {
        //
        delegate?.updateDetailModel(with: .dueDate, value: sender.date as AnyObject)
    }
}
