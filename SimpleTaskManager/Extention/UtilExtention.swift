//
//  UIExtention.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit
//
extension UIColor {
    //
    public static func standardColorList() -> [UIColor] {
        return [UIColor.black,
                .blue,
                .brown,
                .clear,
                .cyan,
                .darkGray,
                .darkText,
                .gray,
                .green,
                .lightGray,
                .lightText,
                .magenta,
                .orange,
                .purple,
                .red,
                .white,
                .yellow]
    }
    //
    public func convertToString() -> String {
        //
        let components = colorComponents
        let colorAsString = String("\(components.red),\(components.green),\(components.blue),\(components.alpha)")
        //
        return colorAsString
    }
    //
    internal var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    internal var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}
//
extension String {
    //
    public func convertToColor() -> UIColor? {
        //
        let components = self.components(separatedBy: ",")
        //
        guard let theRed = components[0].cgFloatValue,
            let theGreen = components[1].cgFloatValue,
            let theBlue = components[2].cgFloatValue,
            let theAlpha = components[3].cgFloatValue else {
            //
                return nil
        }
        //
        let theColor = UIColor(red: theRed, green: theGreen, blue: theBlue,alpha:theAlpha)
        //
        return theColor
    }
    //
    internal var cgFloatValue: CGFloat? {
        guard let doubleValue = Double(self) else {
            return nil
        }
        
        return CGFloat(doubleValue)
    }
}
//
extension UILabel {
    //
    override open func awakeFromNib() {
        super.awakeFromNib()
        //
        font = UIFont(name: STMDefault.font.labelMain, size: STMDefault.font.labelMinorSize)
    }
}
//
extension UIButton {
    //
    override open func awakeFromNib() {
        super.awakeFromNib()
        //
        titleLabel?.font = UIFont(name: STMDefault.font.labelMain, size: STMDefault.font.buttonMainSize)
    }
}

//
extension Date {
    //
    func returnString(with style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
//
public typealias AlertAction = ((UIAlertAction) -> Void)?
//
extension UIViewController {
    //
    public func showIncorectTitelAlert() {
        //
        let alert = UIAlertController(title: "??",
                                      message: "Pls consider more reasonable title!",
                                      preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK",
                                           style: .cancel,
                                           handler: { _ in
                
            }))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    //
    public func showUpdateAlert(with confirm: AlertAction, cancelAction:AlertAction) {
        //
        let alert = UIAlertController(title: "",
                                      message: "Would you like to save your changes?",
                                      preferredStyle: .alert)
        //
            alert.addAction(.genericCancel(with: cancelAction))
            alert.addAction(.confirmSave(with:confirm))
        
        self.present(alert, animated: true, completion: {
            
        })
    }
    //
    public func pushControllerBack(animated:Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
}
//
extension UIAlertAction {
    //
    static func genericCancel(with action: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .default, handler:action)
    }
    //
    static func confirmSave(with action: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler:action)
    }
}