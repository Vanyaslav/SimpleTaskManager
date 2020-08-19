//
//  UITableView+Ext.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 18/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ cell: T, index: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: cell.dequeueIdentifier, for: index) as? T
    }
}

extension UITableViewCell {
    var dequeueIdentifier: String {
        return String(describing: self.self)
    }
}
