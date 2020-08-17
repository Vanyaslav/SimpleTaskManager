//
//  Alerts.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/05/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
//
public typealias AlertAction = ((UIAlertAction) -> Void)?
//
extension UIViewController {
    public func showIncorectTitelAlert() {
        let alert = UIAlertController(title: "??",
                                      message: "Pls consider more reasonable title!",
                                      preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK",
                                       style: .cancel,
                                       handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showUpdateAlert(with confirm: AlertAction, cancelAction: AlertAction) {
        let alert = UIAlertController(title: "",
                                      message: "Would you like to save your changes?",
                                      preferredStyle: .alert)
        
        alert.addAction(.genericCancel(with: cancelAction))
        alert.addAction(.confirmSave(with:confirm))
        
        self.present(alert, animated: true, completion: nil)
    }
    //
    public func pushControllerBack(animated:Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
}
//
extension UIAlertAction {
    static func genericCancel(with action: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .default, handler:action)
    }

    static func confirmSave(with action: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler:action)
    }
}
