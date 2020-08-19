//
//  UIKit+Ext.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 19/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

extension UIColor {
    public static var standardColorList: [UIColor] {
        return [UIColor.black,
                .blue,
                .brown,
                //.clear,
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
    
    public func convertToString() -> String {
        let components = colorComponents
        let colorAsString = String("\(components.red),\(components.green),\(components.blue),\(components.alpha)")
        return colorAsString
    }
    
    internal var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    
    internal var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}

extension UILabel {
    override open func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont(name: STMDefault.font.labelMain, size: STMDefault.font.labelMinorSize)
    }
}

extension UIButton {
    override open func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.font = UIFont(name: STMDefault.font.labelMain, size: STMDefault.font.buttonMainSize)
    }
}
