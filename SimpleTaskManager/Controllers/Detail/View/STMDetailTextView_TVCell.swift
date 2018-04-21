//
//  STMTaskDetailTextView_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMDetailTextView_TVCell: UITableViewCell, UITextViewDelegate {
    //
    weak var delegate:RecordDetailUpdate?
    //
    @IBOutlet weak var taskDescription: UITextView!
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        //
        taskDescription.delegate = self
    }
    ////
    func textViewDidChange(_ textView: UITextView) {
        // delegate
        delegate?.updateDetailModel(with:.description, value:textView.text as AnyObject)
    }
}
