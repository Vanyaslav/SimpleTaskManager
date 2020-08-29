//
//  STMAddNewCategory_VC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

///
class STMAddNewCategory_VC: UIViewController {
    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleTextView: UITextField!
    
    var viewModel: STMAddNewCategory_VM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.addTarget(self,
                             action: #selector(saveNewCategory),
                             for: .touchUpInside)
    }
    
    @objc func saveNewCategory() {
        if let titleText = titleTextView.text,
            titleText.count > viewModel.minTitleLegth {
            let categoryColor = UIColor.standardColorList[colorPicker.selectedRow(inComponent: 0)]
            viewModel.saveCategory(with: titleText, color: categoryColor)
            self.navigationController?.popViewController(animated: true)
        } else {
            showIncorectTitleAlert()
        }
    }
    
    @IBAction func respondTouch() {
        titleTextView.resignFirstResponder()
    }
}
