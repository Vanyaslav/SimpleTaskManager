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
