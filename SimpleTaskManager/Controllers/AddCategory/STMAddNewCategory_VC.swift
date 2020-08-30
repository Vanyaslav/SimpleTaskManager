//
//  STMAddNewCategory_VC.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

extension STMAddNewCategory_VC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let title = textField.text else { return }
        viewModel.updateCategory(with: title)
    }
}
///
class STMAddNewCategory_VC: UIViewController {
    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleTextView: UITextField! {
        didSet {
            titleTextView.delegate = self
        }
    }
    
    var viewModel: STMAddNewCategory_VM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.addTarget(self,
                             action: #selector(saveNewCategory),
                             for: .touchUpInside)
    }
    
    @objc func saveNewCategory() {
        if viewModel.isEligible {
            viewModel.saveCategory()
            self.navigationController?.popViewController(animated: true)
        } else {
            showIncorectTitleAlert()
        }
    }
    
    @IBAction func respondTouch() {
        titleTextView.resignFirstResponder()
    }
}
