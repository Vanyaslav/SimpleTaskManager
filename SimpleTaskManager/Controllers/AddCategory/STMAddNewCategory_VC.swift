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
        viewModel.categoryTitle = title
    }
}
///
class STMAddNewCategory_VC: UIViewController {
    @IBOutlet weak var colorPicker: UIPickerView!
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.addTarget(self,
                                 action: #selector(saveNewCategory),
                                 for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var titleTextView: UITextField! {
        didSet {
            titleTextView.delegate = self
        }
    }
    
    var viewModel: STMAddNewCategory_VM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemGray6
    }
    
    @objc func saveNewCategory() {
        if viewModel.saveCategory() {
            self.navigationController?.popViewController(animated: true)
        } else {
            showIncorectTitleAlert()
        }
    }
    
    @IBAction func respondTouch() {
        titleTextView.resignFirstResponder()
    }
}
