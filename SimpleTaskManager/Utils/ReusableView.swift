//
//  ReusableView.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 19/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
