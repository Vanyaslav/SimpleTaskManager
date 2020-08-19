//
//  UIExtention.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import UIKit

extension String {
    public func convertToColor() -> UIColor? {
        let components = self.components(separatedBy: ",")
        
        guard let red = components[0].cgFloatValue,
            let green = components[1].cgFloatValue,
            let blue = components[2].cgFloatValue,
            let alpha = components[3].cgFloatValue else { return nil }

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    internal var cgFloatValue: CGFloat? {
        guard let doubleValue = Double(self) else { return nil }
        return CGFloat(doubleValue)
    }
}

extension Date {
    func getString(with style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}
