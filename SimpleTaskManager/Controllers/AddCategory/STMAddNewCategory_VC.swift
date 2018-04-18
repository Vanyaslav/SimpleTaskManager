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
    //
    @IBOutlet var colorPicker:UIPickerView!
    //
    @IBOutlet var saveButton:UIButton!
    //
    @IBOutlet var titleTextView:UITextField!
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveButton.addTarget(self, action: #selector(saveNewCategory), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
    @objc func saveNewCategory() {
        //
        if (titleTextView.text?.count)! > 2 {
            let theColor = UIColor.standardColorList()[colorPicker.selectedRow(inComponent: 0)]
            STMCategory.createTaskCategory(with: titleTextView.text!, color: theColor)
        } else {
            let alert = UIAlertController(title: "??",
                                          message: "Pls consider more reasonable title!",
                                          preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                    
                }))
            
            self.present(alert, animated: true, completion: {
                
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
