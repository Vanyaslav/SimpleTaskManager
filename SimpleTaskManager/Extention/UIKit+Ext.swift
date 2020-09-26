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
    
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
}

extension UILabel {
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        font = UIFont(name: STMDefault.font.labelMain,
                      size: STMDefault.font.labelMinorSize)
    }
}

extension UIButton {
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel?.font = UIFont(name: STMDefault.font.labelMain,
                                  size: STMDefault.font.buttonMainSize)
    }
}
