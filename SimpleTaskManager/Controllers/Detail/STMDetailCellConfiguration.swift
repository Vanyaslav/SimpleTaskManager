//
//  STMDetailCellConfiguration.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 27/08/2020.
//  Copyright © 2020 Tomas Baculák. All rights reserved.
//

import Foundation

protocol STMDetailCellConfiguration {
    var viewModel: STMTaskDetail_VM { get set }
    
    func configure(with viewModel: STMTaskDetail_VM)
}

extension STMDetailCellConfiguration {
    mutating func configure(with viewModel: STMTaskDetail_VM) {
        self.viewModel = viewModel
    }
}
