//
//  UITableView+Ext.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 19/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import UIKit

extension UITableViewCell: ReusableView {}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell \(T.self)")
        }
        return cell
    }
}
