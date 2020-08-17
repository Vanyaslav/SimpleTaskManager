//
//  STMDetail_Title_TVCell.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

class STMDetail_Title_TVCell: STMTextField_TVCell, UITextFieldDelegate {
    //
    weak var delegate: STMRecordDetailProtocol?
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
        ////
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification,
                                               object: textField,
                                               queue: nil,
                                               using: { [weak self] notification in
                                                if let taskNameField = notification.object as? UITextField {
                                                    self?.delegate?.updateDetailModel(with: .title,
                                                                                      value: taskNameField.text as AnyObject)
                                                }
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UITextField.textDidChangeNotification,
                                                  object:textField)
    }
}
